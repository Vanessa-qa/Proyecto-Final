//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module buffer3
(
	//Entradas
	input clk,
	input wire [31:0] Res,
	input wire zero,
	
	//Salidas
	output reg [31:0] OUTRes,
	output reg OUTzero
);

always @(posedge clk) begin
    OUTRes <= Res;
    OUTzero <= zero;
end

endmodule