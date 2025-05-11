//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Fase2_tb;

	//Señal
	reg clk;    // Señal de reloj
	
	//Instancia de la Fase 1
	TipoI f2(.clk(clk));
	
	always #50 clk = ~clk;
	
	//Pruebas
	initial begin
		//Inicializamos el reloj
		clk = 0;
		#2000;
		$finish;
	end

endmodule