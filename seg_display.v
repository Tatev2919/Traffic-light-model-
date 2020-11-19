module seg_display(
  input [7:0] dec_num,
  input en,
  output reg [6:0] out_num
);
  always @(*)
    begin
      if(!en) begin 
          case (dec_num)
            8'b00000000:out_num = 7'b1111011;
            8'b00000001:out_num = 7'b0110000;
            8'b00000010:out_num = 7'b1101101;
            8'b00000011:out_num = 7'b1111001;
            8'b00000100:out_num = 7'b0110011;
            8'b00000101:out_num = 7'b1011011;
            8'b00000110:out_num = 7'b1011111;
            8'b00000111:out_num = 7'b1110000;
            8'b00001000:out_num = 7'b1111111;
            8'b00001001:out_num = 7'b1111011;
 	    default: out_num = 7'b0;
          endcase
      end
      else
        out_num = 7'b0;
    end
  
endmodule 