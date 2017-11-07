module RAM (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] addr_interface,
    input [31:0] data_in,
    input MEM_R_en, MEM_W_en,
    output [31:0] data_out
);
    reg [7:0] _RAM[0:255];
    wire [7:0] addr;
    assign addr = {addr_interface[7:2], 2'b0};
    always @(posedge clk) begin
        if(rst) begin
            {_RAM[0], _RAM[1], _RAM[2], _RAM[3]} = 32'd0;
            {_RAM[4], _RAM[5], _RAM[6], _RAM[7]} = 32'd1;
            {_RAM[8], _RAM[9], _RAM[10], _RAM[11]} = 32'd2;
            {_RAM[12], _RAM[13], _RAM[14], _RAM[15]} = 32'd3;
            {_RAM[16], _RAM[17], _RAM[18], _RAM[19]} = 32'd4;
            {_RAM[20], _RAM[21], _RAM[22], _RAM[23]} = 32'd5;
            {_RAM[24], _RAM[25], _RAM[26], _RAM[27]} = 32'd6;
            {_RAM[28], _RAM[29], _RAM[30], _RAM[31]} = 32'd7;
            {_RAM[32], _RAM[33], _RAM[34], _RAM[35]} = 32'd8;
            {_RAM[36], _RAM[37], _RAM[38], _RAM[39]} = 32'd9;
        end
        else begin
            if(MEM_W_en)
                {_RAM[addr], _RAM[addr + 1], _RAM[addr + 2], _RAM[addr + 3]} <= data_in;
            // if(MEM_R_en)
            //     data_out <= {_RAM[addr], _RAM[addr + 1], _RAM[addr + 2], _RAM[addr + 3]};
        end
    end
    assign data_out = MEM_R_en ? {_RAM[addr], _RAM[addr + 1], _RAM[addr + 2], _RAM[addr + 3]} : 32'b0;
endmodule