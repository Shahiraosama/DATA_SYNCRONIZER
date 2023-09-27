module DATA_SYNC #(parameter WIDTH = 8 , parameter STAGES = 2) (

input	wire			CLK,
input	wire			RST,
input	wire			bus_enable,
input	wire	[WIDTH-1:0]	unsync_bus,
output	reg			enable_pulse,
output	reg	[WIDTH-1:0]	sync_bus 
);

wire	D;
wire	Q;

wire	[WIDTH-1:0]	Q_REG1;
wire	[WIDTH-1:0]	D_REG1;

//reg	REG1;
//reg	REG2;


PULSE_GEN pulse_gen_unit (.CLK(CLK),.RST(RST),.D(Q),.OUT(D));

MULTI_FF #(STAGES) syncronizer (.CLK(CLK),.RST(RST),.D(bus_enable),.OUT(Q));

MUX_2X1 #(WIDTH) mux (.IN1(unsync_bus),.IN0(Q_REG1),.SEL(D),.OUT(D_REG1));


always@(posedge CLK , negedge RST)
begin

if(!RST)
begin

sync_bus <= 'b0;

end

else
begin

sync_bus <= D_REG1;

end

end





always@(posedge CLK , negedge RST)
begin

if(!RST)
begin

enable_pulse <= 'b0;

end

else
begin

enable_pulse <= D;

end

end


assign Q_REG1 = sync_bus;


endmodule
