module MUX_3_1 #(parameter n = 1) (
    input [1:0] select,
    input [n-1:0] operand0, operand1, operand2,
    output [n-1:0] result
);
    assign result = select == 2'd2 ? operand2 : select == 2'd1 ? operand1 : operand0;
endmodule