//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Mux2
(
	//Entradas
	input wire ALUSrc,             //Selector
	input wire [31:0] ReadD2,      //Dato de registro 2
	input wire [31:0] Exten,       //Extensor
	
	//Salida
	output reg [31:0] DataOut      //Dato de salida
);

always @(*) begin
	case (ALUSrc)
		1'b1: begin
			DataOut = Exten;
		end
		1'b0: begin
			DataOut = ReadD2;
		end
	endcase
end

endmodule
