//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module CicloFetch
(
	input clk,                  //Señal de reloj
	input wire [31:0] DataIn,   //Dato que entra en PC
	output wire [31:0] Rsum,    //Resultado del sumador
	output wire [31:0] Inst     //Instrucción completa
);

wire [31:0] Address, InstTemp;

//Instancia del Contador de programa
PC pc
	(
		.data_in(DataIn), 
		.data_out(Address),
		.clk(clk)
	);
	
//Instancia del Sumador
SUM sum
	(
		.data_in(Address), 
		.data_out(Rsum)
	);

//Instancia de la Memoria de Instrucciones
MemoriaInst mem
	(
		.clk(clk),
		.Dir(Address), 
		.Inst(Inst)
	);
	
//Instancia del Buffer 1
buffer1 b1
	(
		.clk(clk),
		.InstIN(InstTemp),
		.SUMIN(SumTemp),
		.InstOUT(Inst),
		.SUMOUT(Rsum)
	);

endmodule
