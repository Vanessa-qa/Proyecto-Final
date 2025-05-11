//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module buffer4
(
	//Entradas
	input clk,
	input wire [31:0] MemRead,
	
	//Salida
	output reg [31:0] OUTMemRead
);

always @(posedge clk) begin
    OUTMemRead <= MemRead;
end

endmodule
