module InstructionMemory (
    input  wire [31:0] A,   // Byte address
    output wire [31:0] RD   // Instruction at address A
);

    reg [31:0] memory [0:255];  // 256 words = 1024 bytes

    assign RD = memory[A[9:2]];  // Word-aligned access (ignoring byte offset bits)

endmodule
