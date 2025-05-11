//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

//Memoria de datos
module MemDatos
( 
	//Entradas
	input wire clk,                 //Señal de reloj
	input wire [31:0] Addr,         //Dirección de escritura
	input wire [31:0] Data,         //Dato a escribir
	input wire MemWrite,            //Habilita la escritura
	input wire MemRead,             //Habilita la lectura
	
	//Salida
	output reg [31:0] ReadMemData   //Dato de lectura
);

    reg [31:0] Memdata [0:99];  //Memoria de datos

    always @(posedge clk) begin
    if (MemWrite)
        Memdata[Addr] <= Data;     // Escritura
	end

	always @(*) begin
        if (MemRead)
            ReadMemData = Memdata[Addr];  //lectura
        else
            ReadMemData = 32'b0;
    end

endmodule
