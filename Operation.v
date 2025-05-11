//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module operation
(
	//Entradas
	input wire ALUSrc,           //Señal para el multiplexor
	input wire [1:0]ALUOp,       //Señal para seleccionar el tipo de instrucción 
	input wire [31:0]data1ALU,   //Dato 1 del primer registro del BR 
	input wire [31:0]data2ALU,   //Dato 2 del segundo registro del BR
	input wire [31:0]datatypeI,  //Dato de instrucción tipo I
	input wire [5:0]Function,    //Instrucción tipo R
	input wire [5:0]InstI,       //Instrucción especial tipo I
	
	//Salidas
	output wire zero,                 //Señal de que el resultado fue cero
	output wire [31:0]ALUresult   //Resultado de la operación
);

//Conexiones internas
wire [31:0] bALU;      //Conexion del resultado de seleccion del multiplexor
wire [3:0] selALU;     //Operación a ejecutar en la ALU

//Instancia del multiplexor 2
Mux2 Mux02
	(
		.ALUSrc(ALUSrc),
		.ReadD2(data2ALU),
		.Exten(datatypeI),
		.DataOut(bALU)
	);
	
//Instancia de la ALU de Control
ALUCtrl aluCtrl
	(
		.Op(ALUOp),
		.Function(Function),
		.InstI(InstI),
		.OPAlu(selALU)
	);
	
//Instancia de la ALU de Operaciones
Alu alu
	(
		.A(data1ALU),
		.B(bALU),
		.OP(selALU),
		.Res(ALUresult),
		.zero(zero)
	);
	
endmodule