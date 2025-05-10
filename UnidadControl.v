//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module UniCtrl
(
	//Entrada
	input wire [5:0] Op,     //Tipo de instrucción
	
	//Salidas
	output reg RegDst,       //Manipula el multiplexor 1
	output reg Branch,       //Branch
	output reg MemRead,      //Leer memoria de datos
	output reg MemToReg,     //Permite guardar resultados en registro
	output reg MemToWrite,   //Permite escribir en la memoria de datos
	output reg [1:0] AluOp,  //Le señala a la AluCtrl la opcion a elegir
	output reg ALUSrc,       //Manipula el multiplexor 2
	output reg RegToWrite    //Permite escribir en el banco de registros
);

always @(*) begin
	case (Op)
	
		//Instrucción tipo R
		6'b000000: begin
			RegDst = 1'b1;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b10;
			ALUSrc = 1'b0;
			RegToWrite = 1'b1;
		end
		
		//Instrucciones tipo I
		6'b000100: begin          //BEQ Branch if Equal
			RegDst = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b01;
			ALUSrc = 1'b0;
			RegToWrite = 1'b0;
		end
		6'b000101: begin          //BNE Branch if Not Equal
			RegDst = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b01;
			ALUSrc = 1'b0;
			RegToWrite = 1'b0;
		end
		6'b001010: begin          //SLTI Set on Less Than Immediate
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b11;
			ALUSrc = 1'b1;
			RegToWrite = 1'b1;
		end
		6'b000111: begin          //BGTZ Branch if Greater Than Zero
			RegDst = 1'b0;
			Branch = 1'b1;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b01;
			ALUSrc = 1'b0;
			RegToWrite = 1'b0;
		end
		6'b101011: begin          //SW Store Word
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b1;
			AluOp = 2'b00;
			ALUSrc = 1'b1;
			RegToWrite = 1'b0;
		end
		6'b100011: begin          //LW Load Word
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b1;
			MemToReg = 1'b1;
			MemToWrite = 1'b0;
			AluOp = 2'b00;
			ALUSrc = 1'b1;
			RegToWrite = 1'b1;
		end
		6'b001100: begin          //ANDI AND Immediate
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b11;
			ALUSrc = 1'b1;
			RegToWrite = 1'b1;
		end
		6'b001101: begin          //ORI OR Immediate
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b11;
			ALUSrc = 1'b1;
			RegToWrite = 1'b1;
		end
		6'b001000: begin          //ADDI Add Immediate
			RegDst = 1'b0;
			Branch = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemToWrite = 1'b0;
			AluOp = 2'b00;
			ALUSrc = 1'b1;
			RegToWrite = 1'b1;
		end
		
	endcase
end

endmodule
