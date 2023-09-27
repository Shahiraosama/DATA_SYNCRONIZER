module PULSE_GEN (

input	wire		CLK,
input	wire		RST,
input	wire		D,
output	wire		OUT
);

reg	Q;
wire	O_INV;

always@(posedge CLK or negedge RST)
begin

if(!RST)
begin


Q <= 'b0;

end

else
begin

Q <= D;

end

end


assign O_INV = ~Q;
assign OUT = O_INV & D ;

endmodule
