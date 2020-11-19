module top(output [6:0] out,
           input clk,
           input rst,
           output reg red,yellow,green);

wire rst_out,we,out1;
reg rst_timer;
wire en;
wire [7:0] out_num;
reg [7:0] out_num_r; 
  
  timer u1(
    .clk(clk),
    .rst(rst_timer),
    .out(out1),
    .we(we),
    .rst_out(rst_out));

  shift s1(
    .clk(clk),
    .rst(rst_out),
    .we(we),
    .in(out1),
    .out(out_num)
  );
  seg_display d1(
    .dec_num(out_num),
    .en(rst_timer),
    .out_num(out)
  );

  parameter RED = 2'd0, 
    YELLOW1 = 2'd1,
    YELLOW2 = 2'd2,
    GREEN = 2'd3;
    reg [6:0] cnt; 
    reg [1:0] state;
    reg [1:0] next_state;
    reg counter; 
    assign en = (cnt == 7'd98);
  
  always @(posedge clk or posedge rst)
    begin
      if (rst) begin
    	  state <= RED;
      end
      else
          state <= next_state;
  end

  always @(posedge clk) begin 
    if(rst) begin 
    	out_num_r <= 8'b0;
    end
    else begin 
    	out_num_r <= out_num;
    end
  end
  
  
  always @(posedge clk ) begin 
    if( (state == YELLOW1) || (state == YELLOW2)) begin
		if(!en) begin 
              cnt <= cnt + 7'b1;
          end
          else 
              cnt <= 7'b0; 
      end
   end 
  
  always @(*)
    begin
      if(rst) begin
          rst_timer = 1'b1;
          next_state = RED;
      end
      
      else
        begin
            case(state)
              RED: begin
                rst_timer = 1'b0;
                if(out_num == 8'b0 && out_num != out_num_r) begin
                      next_state = YELLOW1; 	  
                end
	      else next_state = RED;
              end
              YELLOW1: begin
                rst_timer = 1'b1;
                if(en) begin 
                    next_state = GREEN;
                end
	      else next_state = YELLOW1;
              end
              YELLOW2: begin 
                rst_timer = 1'b1;
                if(en) begin 
                      next_state = RED; 
                end
		else next_state = YELLOW2;
              end 
              GREEN: begin
                rst_timer = 1'b0;
                if(out_num == 8'b0 &&  out_num != out_num_r) begin 
                    next_state = YELLOW2;
                end
		else next_state = GREEN;
	      end
              default:begin
                  rst_timer = 1'b0;
                  next_state = RED; 
              end	
            endcase
          end 
    end	

  always @(state) begin
    case(state)
      RED:    begin red=1; yellow=0; green=0; end
      YELLOW1:begin red=0; yellow=1; green=0; end
      YELLOW2:begin red=0; yellow=1; green=0; end
      GREEN:  begin red=0; yellow=0; green=1; end
      default:begin red=1; yellow=0; green=0; end
    endcase
  end
  
endmodule

 


