module Sign_extend #(parameter n = 16)(
	input [n-1 : 0] in,
	output [2*n -1 : 0] out
);
	assign out = {{n{in[n-1]}},in};
endmodule