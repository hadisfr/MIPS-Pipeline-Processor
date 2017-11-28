module Counter #(parameter n = 1) (
    input clk,    // Clock
    input rst,  // Asynchronous reset active high
    input en, // Clock Enable
    output [n - 1:0] out
);
    wire [n - 1:0] next;
    assign next = out + 1;
    Reg #(n) counter_reg(clk, rst, rst | en, next, out);
endmodule