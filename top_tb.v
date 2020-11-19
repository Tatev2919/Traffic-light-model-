module top_tb;
  reg clk,rst;
  wire [6:0] out;
  wire green ,red,yellow;

 top uut (
   .clk(clk), 
   .out(out),
   .rst(rst),
   .red(red),
   .green(green),
   .yellow(yellow)
 ); 
  
  initial begin
    $dumpfile("dump1.vcd"); $dumpvars;
  end

  initial begin 
    clk = 1'b0;
    rst = 1'b1;
    #22;
    rst = 1'b0;
    #50000;
    $finish;
  end
  
  always #10 clk = ~clk;
  
endmodule