//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module ALUCtrl
(
	input [1:0] Op,
	input [5:0] Function,
	output reg [3:0] OPAlu
);

always @(*)begin
	case (Op)
		2'b10: begin		            //Tipo R
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
	endcase
end
endmodule
