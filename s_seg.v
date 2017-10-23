module s_seg(input [3:0] count, output reg [6:0] hex);
    always @(count) begin
        hex = 7'b0;
        case (count)
            4'd0: hex = 7'b1000000;
            4'd1: hex = 7'b1111001;
            4'd2: hex = 7'b0100100;
            4'd3: hex = 7'b0110000;
            4'd4: hex = 7'b0011001;
            4'd5: hex = 7'b0010010;
            4'd6: hex = 7'b0000010;
            4'd7: hex = 7'b1111000;
            4'd8: hex = 7'b0000000;
            4'd9: hex = 7'b0010000;
            4'd10: hex = 7'b0001000;
            4'd11: hex = 7'b0000011;
            4'd12: hex = 7'b1000110;
            4'd13: hex = 7'b0100001;
            4'd14: hex = 7'b0000110;
            4'd15: hex = 7'b0001110;
            default : hex = 7'b0;
        endcase
    end
endmodule