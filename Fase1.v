//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Fase1
(
	input clk
);

//Conexion entre el ciclo fetch y el datapath
wire [31:0] Inst;

//Instancia del Ciclo Fetch
CicloFetch cf
	(
		.clk(clk),
		.Inst(Inst)
	);
	
//Instancia de la instrucción Tipo R
TipoR tr
	(
		.clk(clk),
		.Inst(Inst)
	);
	
endmodule
