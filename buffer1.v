//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module buffer1
(
	//Entradas
	input clk,
	input wire [31:0]InstIN,
	input wire [31:0]SUMIN,
	
	//Salidas
	output reg [31:0]InstOUT,
	output reg [31:0]SUMOUT
);

always @(posedge clk) begin
    InstOUT <= InstIN;
	SUMOUT <= SUMIN;
end

endmodule