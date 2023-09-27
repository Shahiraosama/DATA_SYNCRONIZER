module MULTI_FF #(parameter STAGES = 2) (

input	wire		CLK,
input	wire		RST,
input	wire		D,
output	reg		OUT


);

reg	[STAGES-1:0]	FF	;


always@(posedge CLK or negedge RST)
begin
if(!RST)

begin

OUT <= 'b0;
FF <= 'b0;

end

else
begin

FF <= { FF[STAGES-2:0] , D };
OUT <= FF[STAGES-1] ;

end


end


endmodule
