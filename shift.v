module shift (
       output [7:0] out,
       input clk,
       input rst,
       input we,
       input in);
		 
reg [7:0] g, out_r;

assign out = out_r; 

always@(posedge clk or posedge rst) begin
	if(rst)
	begin
		g <= 8'd0;
		out_r <= 8'd0;
	end
	else begin
	  if(we) begin
          	g <= (g >> 1);
          	g[7] <= in; 
	  end
	  else begin
	 	out_r <= g;
	  end
	end
end

endmodule