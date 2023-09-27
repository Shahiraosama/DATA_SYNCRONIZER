module DATA_SYNC_TB ;

parameter	WIDTH = 8;
parameter	STAGES = 2;

reg			CLK_tb;
reg			RST_tb;
reg			bus_enable_tb;
reg	[WIDTH-1:0]	unsync_bus_tb;
wire			enable_pulse_tb;
wire	[WIDTH-1:0]	sync_bus_tb;





localparam T = 10;


always
begin

#(T/2.0) CLK_tb =  ~CLK_tb ;

end


DATA_SYNC #(.WIDTH(WIDTH) , .STAGES(STAGES)) DUT (

.CLK(CLK_tb),
.RST(RST_tb),
.bus_enable (bus_enable_tb),
.unsync_bus (unsync_bus_tb),
.enable_pulse (enable_pulse_tb),
.sync_bus (sync_bus_tb)

);


initial
begin

CLK_tb ='b0;
RST_tb = 'b1;
bus_enable_tb = 'b0;
unsync_bus_tb ='b11001100;


RESET_CHECK ;

#T
	bus_enable_tb ='b1 ;	unsync_bus_tb = 'b11001100;	check_result (unsync_bus_tb);


	bus_enable_tb ='b0;	unsync_bus_tb = 'b11001100;	check_result (unsync_bus_tb);


	bus_enable_tb ='b1;	unsync_bus_tb = 'b11001111;	check_result(unsync_bus_tb);


#(10*T) $stop;


end


task RESET_CHECK ;

begin
RST_tb ='b0;

@(negedge CLK_tb)
begin

if(enable_pulse_tb != 0 && sync_bus_tb != 0)
begin

$display ("The Reset check FAILED");

end

end

RST_tb ='b1;

end
endtask


task check_result ;


input	[WIDTH-1:0] X;

begin

@(negedge CLK_tb)
begin

if(X != unsync_bus_tb)
begin

$display ("Error: the value of unsync_bus should be %0b but it is %0b",X,unsync_bus_tb);

end

else
begin
$display ("the check on unsync_bus PASSED");
end
end
#(4*T);
end
endtask

endmodule


