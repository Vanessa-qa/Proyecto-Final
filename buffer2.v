//Jonathan Garcia Tovar
//Laura Vanessa Quintero Arreola

module buffer2
(
	//Entradas
	input clk,
	input wire RegDst,  
	input wire Branch,      
	input wire MemRead,
	input wire MemToReg,
	input wire MemToWrite,
	input wire [1:0] AluOp,
	input wire ALUSrc, 
	input wire RegToWrite,
	input wire [31:0] DataReg1,
	input wire [31:0] DataReg2,
	input wire [31:0] SigEx,
	
	//Salidas
	output reg OUTRegDst,  
	output reg OUTBranch,      
	output reg OUTMemRead,
	output reg OUTMemToReg,
	output reg OUTMemToWrite,
	output reg [1:0] OUTAluOp,
	output reg OUTALUSrc, 
	output reg OUTRegToWrite,
	output reg [31:0] OUTDataReg1,
	output reg [31:0] OUTDataReg2,
	output reg [31:0] OUTSigEx
);

always @(posedge clk) begin
    OUTRegDst     <= RegDst;
    OUTBranch     <= Branch;
    OUTMemRead    <= MemRead;
    OUTMemToReg   <= MemToReg;
    OUTMemToWrite <= MemToWrite;
    OUTAluOp      <= AluOp;
    OUTALUSrc     <= ALUSrc;
    OUTRegToWrite <= RegToWrite;
    OUTDataReg1   <= DataReg1;
    OUTDataReg2   <= DataReg2;
    OUTSigEx      <= SigEx;
end

endmodule