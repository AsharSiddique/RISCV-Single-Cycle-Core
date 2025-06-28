`include "ProgramCounter.v"
`include "InstructionMemory.v"
`include "RegisterFile.v"
`include "CU.v"
`include "ALU.v"
`include "Extend.v"
`include "DataMemory.v"
`include "ALUSrcMux.v"
`include "PCSrcMux.v"
`include "ResultSrcMux.v"
`include "PCPlus4Adder.v"
`include "PCTargetAdder.v"

module Top (CLK);

    input CLK;
    wire [31:0] PC_A, PC_M1, RD_Instr, RF_ALU, M2_ALU, RD2_M2_WD, E_M2_A2, ALU_DM_M3, DM_M3, WD3_M3, A1_M1, A2_M1, PC_A1_A2_IM;
    wire zero, CU_RF, CU_DM, CU_M1, CU_M2, CU_M3;
    wire [1:0] CU_Extend;
    wire [2:0] CU_ALU;

    ProgramCounter PC(
        .CLK(CLK),
        .PCNext(PC_M1),
        .PC(PC_A1_A2_IM)
    );

    InstructionMemory IM(
        .A(PC_A1_A2_IM),
        .RD(RD_Instr)
    );

    RegisterFile RF(
        .CLK(CLK),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .WD3(WD3_M3),
        .WE3(CU_RF),
        .RD1(RF_ALU),
        .RD2(RD2_M2_WD)
    );

    Extend E(
        .Instr(RD_Instr[31:7]),
        .ImmSrc(CU_Extend),
        .ImmExt(E_M2_A2)
    );

    CU CU(
        .Zero(zero),
        .op(RD_Instr[6:0]),
        .funct3(RD_Instr[14:12]),
        .funct7b5(RD_Instr[30]),
        .PCSrc(CU_M1),
        .ResultSrc(CU_M3),
        .MemWrite(CU_DM),
        .ALUSrc(CU_M2),
        .ImmSrc(CU_Extend),
        .RegWrite(CU_RF),
        .ALUControl(CU_ALU)
    );

    ALU ALU(
        .SrcA(RF_ALU),
        .SrcB(M2_ALU),
        .ALUControl(CU_ALU),
        .ALUResult(ALU_DM_M3),
        .Zero(zero)
    );

    DataMemory DM(
        .CLK(CLK),
        .WE(CU_DM),
        .A(ALU_DM_M3),
        .WD(RD2_M2_WD),
        .RD(DM_M3)
    );

    PCSrcMux M1(
        .PCSrc(CU_M1),
        .PCPlus4(A1_M1),
        .PCTarget(A2_M1),
        .PCNext(PC_M1)
    );

    ALUSrcMux M2(
        .ALUSrc(CU_M2),
        .RD2(RD2_M2_WD),
        .ImmExt(E_M2_A2),
        .SrcB(M2_ALU)
    );

    ResultSrcMux M3(
        .ResultSrc(CU_M3),
        .ALUResult(ALU_DM_M3),
        .RD(DM_M3),
        .Result(WD3_M3)
    );

    PCPlus4Adder A1(
        .PC(PC_A1_A2_IM),
        .PCPlus4(A1_M1)
    );

    PCTargetAdder A2(
        .PC(PC_A1_A2_IM),
        .ImmExt(E_M2_A2),
        .PCTarget(A2_M1)
    );

endmodule