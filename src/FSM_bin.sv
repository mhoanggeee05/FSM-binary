module top (
    input  [1:0] SW,      
    input  [0:0] KEY,     
    output [9:0] LEDR     
);

    wire clk;
    wire rst;
    wire w;

    wire [3:0] state;
    wire z;

    
    assign clk = KEY[0];     
    assign w   = SW[1];      
    assign rst = ~SW[0];     

    
    ex1bin uut (
        .clk(clk),
        .rst(rst),
        .w(w),
        .state(state),
        .z(z)
    );

    
    assign LEDR[3:0] = state;   
    assign LEDR[9]   = z;       
    assign LEDR[8:4] = 5'b0; // tắt các LED còn lại 

endmodule

module ex1bin (
	input clk,
	input rst,
	input w,
	output [3:0] state,
	output z
	);
	wire [3:0] tempnxt;
	next_state u1 (.w(w),.rst(rst),.q(tempnxt),.y(state));
	present_state u2 (.rst(rst),.clk(clk),.y(state),.q(tempnxt));
	out u3 (.clk(clk),.rst(rst),.z(z),.w(w));

endmodule 
	
module out( 
	input clk,
	input rst,
	input w,
	output z
	);
	
	wire tempw1;
	wire tempw2;
   wire tempw3;
	wire tempw;

	d_ff u1(.D(w),.clk(clk),.rst(rst),.Q(tempw));
	d_ff u2(.D(tempw),.clk(clk),.rst(rst),.Q(tempw1));
	d_ff u3(.D(tempw1),.clk(clk),.rst(rst),.Q(tempw2));
	d_ff u4(.D(tempw2),.clk(clk),.rst(rst),.Q(tempw3));
	
	wire temp1;
	wire temp2;
	wire temp3;
	wire temp4;
	
	d_ff u5(.D(1'b1),.clk(clk),.rst(rst),.Q(temp1));
	d_ff u6(.D(temp1),.clk(clk),.rst(rst),.Q(temp2));
	d_ff u7(.D(temp2),.clk(clk),.rst(rst),.Q(temp3));
	d_ff u8(.D(temp3),.clk(clk),.rst(rst),.Q(temp4));
	
	assign clkcheck = temp1 &temp2 &temp3 &temp4;
	assign z= (clkcheck &tempw &tempw1 &tempw2 &tempw3 &~rst)|
				 (clkcheck &~tempw &~tempw1 &~tempw2 &~tempw3 &~rst);

endmodule

	
module present_state(
	input rst,
	input clk,
	input [3:0] q,
	output [3:0] y
	);
	

	d_ff u0 (.D(q[0]),.rst(rst),.clk(clk),.Q(y[0]));
	d_ff u1 (.D(q[1]),.rst(rst),.clk(clk),.Q(y[1]));
	d_ff u2 (.D(q[2]),.rst(rst),.clk(clk),.Q(y[2]));
	d_ff u3 (.D(q[3]),.rst(rst),.clk(clk),.Q(y[3]));
	
endmodule

module next_state(
	input w,
	input rst,
	input [3:0] y,
	output [3:0] q
	);

		wire isA = ~y[3]&~y[2]&~y[1]&~y[0];
		wire isB = ~y[3]&~y[2]&~y[1]& y[0];
		wire isC = ~y[3]&~y[2]& y[1]&~y[0];
		wire isD = ~y[3]&~y[2]& y[1]& y[0];
		wire isE = ~y[3]& y[2]&~y[1]&~y[0];
		wire isF = ~y[3]& y[2]&~y[1]& y[0];
		wire isG = ~y[3]& y[2]& y[1]&~y[0];
		wire isH = ~y[3]& y[2]& y[1]& y[0];
		wire isI =  y[3]&~y[2]&~y[1]&~y[0];
		
		wire nextB = (isA | isF | isG | isH | isI) & ~w;
      		wire nextC = isB & ~w;
		wire nextD = isC & ~w;
		wire nextE = (isD | isE) & ~w;
		wire nextF = (isA | isB | isC | isD | isE) & w;
		wire nextG = isF & w;
		wire nextH = isG & w;
		wire nextI = (isH | isI) & w;

    assign q[0] = nextB | nextD | nextF | nextH;
    assign q[1] = nextC | nextD | nextG | nextH;
    assign q[2] = nextE | nextF | nextG | nextH;
    assign q[3] = nextI;

endmodule

module d_ff (
	input logic D,
	input clk,
	input logic rst,
   output logic Q
	);
	
	always_ff @(posedge clk, posedge rst)
	if (rst) 
		Q <= 0;
	else
		Q <= D;
	
endmodule 
