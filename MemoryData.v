//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module MemoryData
(
	//Entradas
	input clk,                       //Señal de reloj
	input wire [31:0]AddrMem,        //Dirección en la memoria de datos
	input wire [31:0]DataMem,        //Dato a escribir en la memoria de datos
	input wire MemWrite,             //Señal de escritura en la memoria
	input wire MemRead,              //Señal de lectura en la memoria
	input wire MemToReg,             //Señal del multiplexor
	
	//Salida
	output wire [31:0]DataOut              //Seleccion del multiplexor
);

//Conexiones internas
wire [31:0] DataOutMem;              //Dato leído de la memoria de datos
wire [31:0] DataMux;                 //Dato de salida del multiplexor

//Instancia de la Memoria de datos
MemDatos MD
	(
		.clk(clk),
		.Addr(AddrMem),
		.Data(DataMem),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.ReadMemData(DataOutMem)
	);
	
//Instancia del multiplexor
Mux3 m3 
	(
		.MemToReg(MemToReg),
		.ReadMem(DataOutMem),
		.Result(AddrMem),
		.DataOut(DataMux)
	);
	
//Instancia del buffer 
buffer4 b4 
	(
		.clk(clk),
		.MemRead(DataMux),
		.OUTMemRead(DataOut)
	);
	
endmodule