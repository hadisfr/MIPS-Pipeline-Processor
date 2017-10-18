module Reg #(parameter n = 1) (
    input clk, rst, ld, input  [n - 1:0] parin,
    output reg  [n - 1:0] w
);
  always@(posedge clk) begin
    if(rst == 1)
      w <= 0;
    else if(ld == 1)
      w <= parin;
  end
endmodule