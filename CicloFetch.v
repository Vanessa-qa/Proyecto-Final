//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module CicloFetch
(
	input clk,                //Señal de reloj
	output wire [31:0] Inst   //Instrucción completa
);

wire [31:0] DataIn, Address;

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
		.data_out(DataIn)
	);

//Instancia de la Memoria de Instrucciones
MemoriaInst mem
	(
		.clk(clk),
		.Dir(Address), 
		.Inst(Inst)
	);

endmodule