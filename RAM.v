module RAM (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input [31:0] addr_interface,
    input [31:0] data_in,
    input MEM_R_en, MEM_W_en,
    output reg [31:0] data_out
);
    reg [7:0] _RAM[0:255];
    wire [7:0] addr;
    assign addr = {addr_interface[7:2], 2'b0};
    always @(posedge clk) begin
        if(rst)
            _RAM[0] = 0;
        else begin
            if(MEM_W_en)
                {_RAM[addr], _RAM[addr + 1], _RAM[addr + 2], _RAM[addr + 3]} = data_in;
            if(MEM_R_en)
                data_out = {_RAM[addr], _RAM[addr + 1], _RAM[addr + 2], _RAM[addr + 3]};
        end
    end
endmodule