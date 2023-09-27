module MUX_2X1 #(parameter WIDTH =8) (

input	wire	[WIDTH-1:0]	IN1,
input	wire	[WIDTH-1:0]	IN0,
input	wire			SEL,
output	wire	[WIDTH-1:0]	OUT	
	
);

assign OUT = (SEL)? IN1 : IN0 ;

endmodule
