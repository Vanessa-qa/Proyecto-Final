//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

//Fase 2 del Proyecto Final. Instrucciones tipo I

module TipoI
(
	input clk	//Señal de reloj
);

//   CONEXIONES
wire [31:0]DataIn;       //Dato de PC
wire [31:0]ResultSum;    //Dato de salida de SUM
wire [31:0]INST;         //Instrucción de 32 bits

wire [5:0] OP, Funct;
wire [4:0] RS, RT, RD;
wire [15:0] I;

//Conexiones con la unidad de control
wire RdT, BRANCH, MeR, MtR, MtW, AsC, RtW;
wire [1:0] ALUOP;

//Conexiones del registro 1 y 2 del banco de registros
wire [31:0] DATAREG1, DATAREG2;

wire [31:0] dataBR;      //Dato de entrada para el banco de registros
wire [4:0] dataMux1;     //Dato de salida del multiplexor 1
wire [31:0] extOut;      //Dato de salida del extensor de signo

//Conexiones del buffer 2
wire [31:0] data1, data2, extensorData;

wire zeroflag;           //Señal de bandera cero
wire [31:0]AluResultOP;        //Resultado de la operacion de la alu

//Conexiones tras pasar el buffer 3
wire zeroBuffer3;
wire [31:0]resultBuffer3;

//    INSTANCIAS
//Instancia del ciclo fetch
CicloFetch CF
	(
		.clk(clk),
		.DataIn(DataIn),
		.Rsum(ResultSum),
		.Inst(INST)
	);
	
//Asignacion de las entradas
assign OP = INST[31:26];
assign RS = INST[25:21];
assign RT = INST[20:16];
assign RD = INST[15:11];
assign Funct = INST[5:0];
assign I = INST[15:0];

//Instancia del branch
branch b1
	(
		.MuxData1(ResultSum),
		.SFdata(extensorData),
		.branchIN(BRANCH),
		.Zflag(zeroBuffer3),
		.MuxDataOut(DataIn)
	);

//Instancia de la Unidad de Control
UniCtrl Uni1
	(
		.Op(OP), 
		.RegDst(RdT), 
		.Branch(BRANCH), 
		.MemRead(MeR),
		.MemToReg(MtR), 
		.MemToWrite(MtW), 
		.AluOp(ALUOP), 
		.ALUSrc(AsC), 
		.RegToWrite(RtW)
	);
	
//Instancia del Banco de Registros
BancoReg Banco1
	(
		.clk(clk), 
		.Reg1(RS), 
		.Reg2(RT), 
		.WriteAddr(dataMux1), 
		.Data(dataBR), 
		.RegEn(RtW), 
		.DataReg1(DATAREG1), 
		.DataReg2(DATAREG2)
	);
	
//Instancia del multiplexor 1
Mux1 m1
	(
		.RegDst(RdT),
		.rt(RT),
		.rd(RD),
		.DataOut(dataMux1)
	);

//Instancia del extensor de signo
Extensor ext
	(
		.dataIN(I),
		.dataOUT(extOut)
	);

//Instancia del buffer 2
buffer2 b2
	(
		.clk(clk),
		.DataReg1(DATAREG1),
		.DataReg2(DATAREG2),
		.SigEx(extOut),
		.OUTDataReg1(data1),
		.OUTDataReg2(data2),
		.OUTSigEx(extensorData)
	);

//Instancia de Operation
operation op
	(
		.ALUSrc(AsC),
		.ALUOp(ALUOP),
		.data1ALU(data1),
		.data2ALU(data2),
		.datatypeI(extensorData),
		.Function(Funct),
		.InstI(OP),
		.zero(zeroflag),
		.ALUresult(AluResultOP)
	);
	
//Instancia del buffer 3
buffer3 b3
	(
		.clk(clk),
		.Res(AluResultOP),
		.zero(zeroflag),
		.OUTRes(resultBuffer3),
		.OUTzero(zeroBuffer3)
	);
	
//Instancia de MemoryData
MemoryData md
	(
		.clk(clk),
		.AddrMem(resultBuffer3),
		.DataMem(data2),
		.MemWrite(MtW),
		.MemRead(MeR),
		.MemToReg(MtR),
		.DataOut(dataBR)
	);

endmodule