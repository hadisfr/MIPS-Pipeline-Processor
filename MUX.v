module MUX #(parameter n = 1) (
    input select,
    input [n-1:0] operand0, operand1,
    output [n-1:0] result
);
    assign result = select ? operand1 : operand0;
endmodule