module Register_file #(parameter n = 32) (
    input clk,    // Clock
    input rst,  // Reset active high
    input [4:0] src1, src2, dest,
    input [n-1:0] WB_value,
    input WB_en,
    output [n-1:0] reg1, reg2
);
    reg [n-1:0] _Register_file [0:n-1];
    always @(negedge clk) begin
        if(rst) begin
            _Register_file[0] <= 0;
            _Register_file[1] <= 1;
            _Register_file[2] <= 2;
            _Register_file[3] <= 3;
            _Register_file[4] <= 4;
            _Register_file[5] <= 5;
            _Register_file[6] <= 6;
            _Register_file[7] <= 7;
            _Register_file[8] <= 8;
            _Register_file[9] <= 9;
            _Register_file[10] <= 10;
            _Register_file[11] <= 11;
            _Register_file[12] <= 12;
            _Register_file[13] <= 13;
            _Register_file[14] <= 14;
            _Register_file[15] <= 15;
            _Register_file[16] <= 16;
            _Register_file[17] <= 17;
            _Register_file[18] <= 18;
            _Register_file[19] <= 19;
            _Register_file[20] <= 20;
            _Register_file[21] <= 21;
            _Register_file[22] <= 22;
            _Register_file[23] <= 23;
            _Register_file[24] <= 24;
            _Register_file[25] <= 25;
            _Register_file[26] <= 26;
            _Register_file[27] <= 27;
            _Register_file[28] <= 28;
            _Register_file[29] <= 29;
            _Register_file[30] <= 30;
            _Register_file[31] <= 31;
        end
        else
            if(WB_en && dest != 0)
                _Register_file[dest] <= WB_value;
    end
    assign reg1 = _Register_file[src1];
    assign reg2 = _Register_file[src2];
endmodule