//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module UniCtrl
(
	//Entrada
	input wire [5:0] Op,     //Tipo de instrucción
	
	//Salidas
	output reg RegDst,       //Manipula el multiplexor 1
	output reg MemToReg,     //Permite guardar resultados en registro
	output reg MemToWrite,   //Permite escribir en la memoria de datos
	output reg [1:0] AluOp,  //Le señala a la AluCtrl la opcion a elegir
	output reg ALUSrc,       //Manipula el multiplexor 2
	output reg RegToWrite    //Permite escribir en el banco de registros
);

always @(*) begin
	case (Op)
		6'b000000: begin     //instrucción de tipo R
			RegDst = 1'b1;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b10;
			ALUSrc = 1'b0;
			RegToWrite = 1'b1;
		end
	endcase
end

endmodule
