`include "ALUDecoder.v"
`include "MainDecoder.v"

module CU (
    input  wire       Zero,
    input  wire [6:0] op,
    input  wire [2:0] funct3,
    input  wire       funct7b5,
    output wire       PCSrc,
    output wire       ResultSrc,
    output wire       MemWrite,
    output wire       ALUSrc,
    output wire [1:0] ImmSrc,
    output wire       RegWrite,
    output wire [2:0] ALUControl
);

    wire [1:0] ALUOp;
    wire       Branch;
    wire       opb5;

    assign opb5 = op[5];

    // Internal control signals from MainDecoder
    MainDecoder main_decoder (
        .op(op),
        .Branch(Branch),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ALUOp(ALUOp)
    );

    // ALU control logic
    ALUDecoder alu_decoder (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .opb5(opb5),
        .funct7b5(funct7b5),
        .ALUControl(ALUControl)
    );

    // Branch decision
    assign PCSrc = Branch & Zero;

endmodule
