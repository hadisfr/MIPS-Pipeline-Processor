module Cache_CTRL (
    input clk,    // Clock
    input rst,  // Reset active High
    // with MEM_stage
    input [17:0] addr,
    input [31:0] data_in,
    input MEM_R_en, MEM_W_en,
    output [31:0] data_out,
    output freeze,
    // with SRAM
    inout  [15:0] SRAM_DQ,   //  SRAM Data bus 16 Bits
    output [17:0] SRAM_ADDR, //  SRAM Address bus 18 Bits
    output        SRAM_UB_N, //  SRAM High-byte Data Mask 
    output        SRAM_LB_N, //  SRAM Low-byte Data Mask 
    output        SRAM_WE_N, //  SRAM Write Enable
    output        SRAM_CE_N, //  SRAM Chip Enable
    output        SRAM_OE_N  //  SRAM Output Enable
);
    parameter LRU = 0, DATA_LEN = 64, TAG_LEN = 9, INDEX_LEN = 6, WAY_LEN = 74,
        WAY0_DATA =  1, WAY0_TAG =  65, WAY0_VAL =  74,
        WAY1_DATA = 75, WAY1_TAG = 139, WAY1_VAL = 148;
    wire [INDEX_LEN-1:0] addr_index;
    wire [TAG_LEN-1:0] addr_tag;
    wire addr_select;
    reg [63:0] data_out_ext_cache;
    wire [63:0] data_out_ext, data_out_ext_SRAM;
    // wire [63:0] data_in_ext;
    reg [148:0] cache[0:63];
    wire SRAM_freeze;
    wire cache_freeze;
    wire SRAM_MEM_en;
    reg SRAM_MEM_R_en, SRAM_MEM_W_en;

    assign addr_index = addr[INDEX_LEN+3-1:3];
    assign addr_tag = addr[TAG_LEN+INDEX_LEN+3-1:INDEX_LEN+3];
    assign addr_select = addr[2];
    assign data_out = MEM_R_en ? (addr_select ? data_out_ext[63:32] : data_out_ext[31:0]) : 32'bz;
    assign data_out_ext = SRAM_MEM_R_en ? data_out_ext_SRAM : data_out_ext_cache;
    // assign data_in_ext = addr_select ? {data_in, 32'b1} : {32'b1, data_in};

    assign freeze = cache_freeze | SRAM_freeze;

    SRAM_CTRL sram_ctrl (
        clk, rst,
        addr[17:0], data_in, SRAM_MEM_R_en, SRAM_MEM_W_en, data_out_ext_SRAM, SRAM_freeze,
        SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N
    );

    assign SRAM_MEM_en = SRAM_MEM_R_en | SRAM_MEM_W_en;
    assign cache_freeze = ~SRAM_MEM_en & (MEM_W_en | (MEM_R_en
        & ~(cache[addr_index][WAY1_TAG+TAG_LEN-1:WAY1_TAG] == addr_tag && cache[addr_index][WAY1_VAL])
        & ~(cache[addr_index][WAY0_TAG+TAG_LEN-1:WAY0_TAG] == addr_tag && cache[addr_index][WAY0_VAL])
    ));

    integer i;
    always@(posedge clk) begin
        if(rst == 1) begin  // reset
            for(i = 0; i < 64; i = i + 1)
                cache[i] <= 149'b0;
            SRAM_MEM_R_en <= 0;
            SRAM_MEM_W_en <= 0;
            // cache_freeze <= 0;
        end // reset
        else begin  // logic
            if(MEM_R_en) begin  // read
                if(freeze) begin
                    if(cache_freeze) begin  // chache_freeze
                        SRAM_MEM_R_en <= 1;
                        // cache_freeze <= 0;
                    end  // chache_freeze
                    else begin  // SRAM_freeze
                        if(cache[addr_index][LRU]) begin  // WAY1
                            cache[addr_index] <= {
                                cache[addr_index][WAY_LEN+WAY1_DATA-1:WAY1_DATA],
                                1'b1, addr_tag, data_out_ext_SRAM,
                                1'b0
                            };
                        end  // WAY1
                        else begin  // WAY0
                            cache[addr_index] <= {
                                1'b1, addr_tag, data_out_ext_SRAM,
                                cache[addr_index][WAY_LEN+WAY0_DATA-1:WAY0_DATA],
                                1'b1
                            };
                        end  // WAY0
                    end  // SRAM_freeze
                end
                else begin
                    if(
                        cache[addr_index][WAY0_TAG+TAG_LEN-1:WAY0_TAG] == addr_tag
                        && cache[addr_index][WAY0_VAL]
                    ) begin
                        data_out_ext_cache <= cache[addr_index][WAY0_DATA+DATA_LEN-1:WAY0_DATA];
                        cache[addr_index][LRU] <= 0;
                    end
                    else if(
                        cache[addr_index][WAY1_TAG+TAG_LEN-1:WAY1_TAG] == addr_tag
                        && cache[addr_index][WAY1_VAL]
                    ) begin
                        data_out_ext_cache <= cache[addr_index][WAY1_DATA+DATA_LEN-1:WAY1_DATA];
                        cache[addr_index][LRU] <= 1;
                    end
                    else begin
                        // cache_freeze <= 1;
                    end
                    SRAM_MEM_R_en <= 0;
                end
            end // read
            else if(MEM_W_en) begin  // write
                if(freeze) begin
                    if(cache_freeze) begin  // cache_freeze
                        SRAM_MEM_W_en <= 1;
                        // cache_freeze <= 0;
                    end  // cache_freeze
                end
                else begin  // new inst
                    if(
                        cache[addr_index][WAY0_TAG+TAG_LEN-1:WAY0_TAG] == addr_tag
                        && cache[addr_index][WAY0_VAL]
                    ) begin
                        // cache[addr_index][WAY0_DATA+DATA_LEN-1:WAY0_DATA] <=
                        //     data_in_ext & cache[addr_index][WAY0_DATA+DATA_LEN-1:WAY0_DATA];
                        cache[addr_index][WAY0_VAL] <= 0;
                    end
                    else if(
                        cache[addr_index][WAY1_TAG+TAG_LEN-1:WAY1_TAG] == addr_tag
                        && cache[addr_index][WAY1_VAL]
                    ) begin
                        // cache[addr_index][WAY1_DATA+DATA_LEN-1:WAY1_DATA] <=
                        //     data_in_ext & cache[addr_index][WAY1_DATA+DATA_LEN-1:WAY1_DATA];
                        cache[addr_index][WAY1_VAL] <= 0;
                    end
                    // cache_freeze <= 1;
                    SRAM_MEM_W_en <= 0;
                end  // new inst
            end // write
            else begin
                SRAM_MEM_R_en <= 0;
                SRAM_MEM_W_en <= 0;
                // cache_freeze <= 0;
            end
        end  // login
    end

endmodule