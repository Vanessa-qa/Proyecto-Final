//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module Fase1_tb;

	//Señal
	reg clk;    // Señal de reloj
	
	//Instancia de la Fase 1
	Fase1 f1(.clk(clk));
	
	always #50 clk = ~clk;
	
	//Pruebas
	initial begin
		//Inicializamos el reloj
		clk = 0;
		#500;
		$finish;
	end

endmodule
