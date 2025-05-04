//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

//Fase 1 del Proyecto Final. Instrucciones tipo R

module TipoR
(
	input clk,               //Señal de reloj
    input wire [31:0] Inst   //Instrucción
);

//Division de la instrucción
wire [5:0] OP, Funct;
wire [4:0] RS, RT, RD;
wire [15:0] I;

//Conexiones Unidad de Control
wire RdT, MtR, MtW, AsC, RtW;
wire [1:0] ALUOP;

//Conexiones Banco de Registros
wire [31:0] DataBR, DATAREG1, DATAREG2;

//Conexiones ALU de Control
wire [3:0] aluCtrlOP;

//Conexiones ALU
wire [31:0] b, ALUresult;

//Conexion Memoria de datos
wire [31:0] READMEM;

//Conexion Multiplexor 1
wire [4:0] dataOut;

//Conexion Multiplexor 2
wire [31:0] ex;

//Asignacion de las entradas
assign OP = Inst [31:26];
assign RS = Inst[25:21];
assign RT = Inst[20:16];
assign RD = Inst[15:11];
assign Funct = Inst[5:0];

//Para instrucción I
assign I = Inst [15:0];

//Instancia de la Unidad de Control
UniCtrl Uni1
	(
		.Op(OP), .RegDst(RdT), .MemToReg(MtR), 
		.MemToWrite(MtW), .AluOp(ALUOP), 
		.ALUSrc(AsC), .RegToWrite(RtW)
	);

//Instancia del Banco de Registros
BancoReg Banco1
	(
		.clk(clk), .Reg1(RS), .Reg2(RT), 
		.WriteAddr(dataOut), .Data(DataBR), 
		.RegEn(RtW), .DataReg1(DATAREG1), 
		.DataReg2(DATAREG2)
	);

//Instancia de la ALU de Control
ALUCtrl AluCtrl
	(
		.Op(ALUOP), .Function(Funct), 
		.OPAlu(aluCtrlOP)
	);

//Instancia de la ALU
Alu Alu1
	(
		.A(DATAREG1), .B(b), 
		.OP(aluCtrlOP), .Res(ALUresult)
	);

//Instancia de la Memoria de datos
MemDatos Mem1
	(
		.clk(clk), .Addr(ALUresult), .Data(DATAREG2), 
		.MemWrite(MtW), .MemRead(READMEM)
	);

//Instancia del Multiplexor numero 1
Mux1 Mux01
	(
		.RegDst(RdT), .rt(RT), 
		.rd(RD), .DataOut(dataOut)
	);

//Instancia del Multiplexor numero 2
Mux2 Mux02
	(
		.ALUSrc(AsC), .ReadD2(DATAREG2),
		.Exten(ex), .DataOut(b)
	);

//Instancia del Multiplexor numero 3
Mux3 Mux03
	(
		.MemToReg(MtR), .ReadMem(READMEM), 
		.Result(ALUresult), .DataOut(DataBR)
	);
	
//Instancia del Extensor de bits
Extensor Ex1
	(
		.dataIN(I), .dataOUT(ex)
	);

endmodule
