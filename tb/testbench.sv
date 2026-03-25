module ex1bin_testbench ();
   logic clk;
	logic rst;
	logic w;
	logic [3:0] state;
	logic z;
	
	ex1bin DUT (.clk(clk),.rst(rst),.w(w),.state(state),.z(z));
	
	always
	begin 
			clk = 1; #5;
			clk = 0; #5;
	end
	
	initial
	begin
		rst=1; w =0;
		#15; rst=0;
		#30; w=1;
		#10; w=0;
		#40; w=1;
		#50; w=0;
		#10; w=1;
		#10; w=0;
	end
endmodule
		
