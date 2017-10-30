module Adder #(parameter n = 1) (
    input signed [n-1:0] operand1, operand2,
    output signed [n:0] result
);
    assign result = operand1 + operand2;
endmodule