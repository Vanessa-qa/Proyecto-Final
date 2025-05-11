//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

//Fase 2 del Proyecto Final. Instrucciones tipo I

module TipoI
(
	input clk		//Señal de reloj
);


//   CONEXIONES

//Conexion del PC
wire [31:0] Address;

//Conexiones del SUM
wire [31:0] dataSUM;

//Conexiones con la Memoria de Instrucciones
wire [31:0] INST, INSTOUT;

//Conexion del buffer 1
wire [31:0] B1sum;

//Division de la instrucción
wire [5:0] OP, Funct;
wire [4:0] RS, RT, RD;
wire [15:0] I;

//Conexion Multiplexor 1
wire [4:0] dataOut;

//Conexiones Unidad de Control
wire RdT, BRAN, MemR, MtR, MtW, AsC, RtW;
wire [1:0] ALUOP;

//Conexiones Banco de Registros
wire [31:0] DataBR, DATAREG1, DATAREG2;

//Conexion del Extensor de Signo
wire [31:0] exten;

//Conexiones del buffer 2
wire B2banreg, out1, out2, out3, out4, out5, out6;
wire [31:0] B2banreg1, B2banreg2, sigExt;
wire [1:0] B2aluop;

//Conexiones ALU de Control
wire [3:0] aluCtrlOP;

//Conexiones del Shift Left
wire [31:0] SLdata;

//Conexion de alu branch
wire [31:0] ALUbranR;

//Conexion del Multiplexor numero 4
wire [31:0] mux4R;	

//Conexion de el and branch
wire andR;

//Conexiones ALU
wire [31:0] b, ALUresult, Zflag;

//Conexiones del buffer 3
wire [31:0] result;
wire flag;

//Conexion Memoria de datos
wire [31:0] READMEM;

//Conexion del buffer 4
wire [31:0] MemResult;


//    INSTANCIAS

//Instancia del Contador de programa
PC pc
	(
		.data_in(mux4R), 
		.data_out(Address),
		.clk(clk)
	);
	
//Instancia del Sumador
SUM sum
	(
		.data_in(Address), 
		.data_out(dataSUM)
	);

//Instancia del buffer 1
buffer1 b1
	(
		.clk(clk), .InstIN(INST), .SUMIN(dataSUM),
		.InstOUT(INSTOUT), .SUMOUT(B1sum)
	);
	
//Instancia de la Memoria de Instrucciones
MemoriaInst mem
	(
		.clk(clk),
		.Dir(Address), 
		.Inst(INST)
	);

//Asignacion de las entradas
assign OP = INSTOUT[31:26];
assign RS = INSTOUT[25:21];
assign RT = INSTOUT[20:16];
assign RD = INSTOUT[15:11];
assign Funct = INSTOUT[5:0];
assign I = INSTOUT[15:0];

//Instancia del Multiplexor numero 1
Mux1 Mux01
	(
		.RegDst(out1), .rt(RT), 
		.rd(RD), .DataOut(dataOut)
	);

//Instancia de la Unidad de Control
UniCtrl Uni1
	(
		.Op(OP), .RegDst(RdT), .Branch(BRAN),
		.MemRead(MemR), .MemToReg(MtR), 
		.MemToWrite(MtW), .AluOp(ALUOP), 
		.ALUSrc(AsC), .RegToWrite(RtW)
	);

//Instancia del Banco de Registros
BancoReg Banco1
	(
		.clk(clk), .Reg1(RS), .Reg2(RT), 
		.WriteAddr(dataOut), .Data(DataBR), 
		.RegEn(B2banreg), .DataReg1(DATAREG1), 
		.DataReg2(DATAREG2)
	);

//Instancia del Extensor de Signo
Extensor Ex1
	(
		.dataIN(I), .dataOUT(exten)
	);

//Instancia del buffer 2
buffer2 b2
	(
		.clk(clk),
		.RegDst(RdT),  
		.Branch(BRAN),      
		.MemRead(MemR),
		.MemToReg(MtR),
		.MemToWrite(MtW),
		.AluOp(ALUOP),
		.ALUSrc(AsC), 
		.RegToWrite(RtW),
		.DataReg1(DATAREG1),
		.DataReg2(DATAREG2),
		.SigEx(exten),
		
		.OUTRegDst(out1),  
		.OUTBranch(out2),      
		.OUTMemRead(out3),
		.OUTMemToReg(out4),
		.OUTMemToWrite(out5),
		.OUTAluOp(B2aluop),
		.OUTALUSrc(out6), 
		.OUTRegToWrite(B2banreg),
		.OUTDataReg1(B2banreg1),
		.OUTDataReg2(B2banreg2),
		.OUTSigEx(SigEx)
	);

//Instancia de la ALU de Control
ALUCtrl AluCtrl
	(
		.Op(B2aluop), .Function(Funct), 
		.InstI(OP), .OPAlu(aluCtrlOP)
	);

//Instancia del Multiplexor numero 2
Mux2 Mux02
	(
		.ALUSrc(out6), .ReadD2(B2banreg2),
		.Exten(SigEx), .DataOut(b)
	);

//Instancia del Shift Left
ShiftLeft sl
	(
		.DataIn(SigEx), .DataOut(SLdata)
	);

//Instancia de la Alu para los branch
ALUbranch ab
	(
		.data1(B1sum), .data2(SLdata),
		.data_out(ALUbranR)
	);

//Instancia del Multiplexor numero 4
Mux4 Mux04
	(
		.ANDbranch(andR), .PC(B1sum),
		.AluBranch(ALUbranR), .DataOut(mux4R)
	);

//Instancia de la compuerta AND para el branch
ANDbranch andB
	(
		.A(out2), .B(flag), .R(andR)
	);

//Instancia de la ALU
Alu Alu1
	(
		.A(DATAREG1), .B(b), .OP(aluCtrlOP), 
		.Res(ALUresult), .zero(Zflag)
	);

//Instancia del buffer 3
buffer3 b3
	(
		.clk(clk),
		.Res(ALUresult),
		.zero(Zflag),
		.OUTRes(result),
		.OUTzero(flag)
	);

//Instancia de la Memoria de datos
MemDatos Mem1
	(
		.clk(clk), .Addr(result), .Data(B2banreg2), 
		.MemWrite(out5), .MemRead(out3), .ReadMemData(READMEM)
	);

//Instancia del buffer 4
buffer4 b4
	(
		.clk(clk), .MemRead(READMEM),
		.OUTMemRead(MemResult)
	);

//Instancia del Multiplexor numero 3
Mux3 Mux03
	(
		.MemToReg(out4), .ReadMem(MemResult), 
		.Result(result), .DataOut(DataBR)
	);
	
endmodule