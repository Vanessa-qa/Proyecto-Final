//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module ALUCtrl
(
	input [1:0] Op,
	input [5:0] Function,    //Funcion para seleccionar en tipo R
	input [5:0] InstI,       //Instrucciones especiales para tipo I
	output reg [3:0] OPAlu
);

always @(*)begin
	case (Op)
		//Tipo R
		2'b10: begin		  
			case (Function)
				6'b100000: begin 		//Suma
					OPAlu = 4'b0010;
				end
				6'b100010: begin		//Resta
					OPAlu = 4'b0110;
				end
				6'b101010: begin		//SLT
					OPAlu = 4'b0111;
				end
				6'b100100: begin		//AND
					OPAlu = 4'b0000;
				end
				6'b100101: begin		//OR
					OPAlu = 4'b0001;
				end
				6'b000000: begin	    //NOP
					OPAlu = 4'b1111;
				end
			default: OPAlu = 4'b1111;
			endcase
		end
		
		//Tipo I
		2'b00: begin
            // Para lw, sw, addi
            OPAlu = 4'b0010;
        end
        2'b01: begin
            // Para beq, bne, bgtz
            OPAlu = 4'b0110;
        end
		2'b11: begin
            // andi, ori, slti
            case (InstI)
                6'b001100: OPAlu = 4'b0000; //ANDI
                6'b001101: OPAlu = 4'b0001; //ORI
                6'b001010: OPAlu = 4'b0111; //SLTI
                default:   OPAlu = 4'b1111; //NOP
            endcase
        end
		
		default: begin
            OPAlu = 4'b1111; //NOP
        end
	endcase
end
endmodule
