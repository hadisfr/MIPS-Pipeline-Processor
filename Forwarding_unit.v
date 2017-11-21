module Forwarding_unit (
    input [4:0] src1, src2,
    input [4:0] ST_src, // previously: dest2
        dest3, dest4,
    input MEM_W_en_2, // won't be used
    input WB_en_3, WB_en_4,
    input has_forwarding,
    output [1:0] val1_s, val2_s, ST_value_s
);
    wire [1:0] val1_s_mid, val2_s_mid, ST_value_s_mid;
    assign val1_s_mid = WB_en_4 & (src1 == dest4)? 2'd2 : WB_en_3 & (src1 == dest3)? 2'd1 : 2'd0; 
    assign val2_s_mid = WB_en_4 & (src2 == dest4)? 2'd2 : WB_en_3 & (src2 == dest3)? 2'd1 : 2'd0; 
    assign ST_value_s_mid = WB_en_4 & (ST_src == dest4)? 2'd2 : WB_en_3 & (ST_src == dest3)? 2'd1 : 2'd0; 
    MUX #(6) forwarding_unit_mux(
        has_forwarding, 6'b0, {val1_s_mid, val2_s_mid, ST_value_s_mid},
        {val1_s, val2_s, ST_value_s}
    );
endmodule