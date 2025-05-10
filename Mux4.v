//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Mux4
(
	//Entradas
	input wire ANDbranch,           //Resultado de la compuerta AND
	input wire [31:0] PC,           //Dato del ciclo fetch
	input wire [31:0] AluBranch,    //Shift letf + (PC + 4)
	
	//Salida
	output reg [31:0] DataOut    //Dato de salida
);

always @(*) begin
	case (ANDbranch)
		1'b1: begin
			DataOut = AluBranch;
		end
		1'b0: begin
			DataOut = PC;
		end
	endcase
end

endmodule
