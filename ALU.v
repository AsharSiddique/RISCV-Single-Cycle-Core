module ALU (
    input  wire [31:0] SrcA,
    input  wire [31:0] SrcB,
    input  wire [2:0]  ALUControl,
    output reg  [31:0] ALUResult,
    output wire        Zero
);

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;               // ADD
            3'b001: ALUResult = SrcA - SrcB;               // SUB
            3'b010: ALUResult = SrcA & SrcB;               // AND
            3'b011: ALUResult = SrcA | SrcB;               // OR
            3'b101: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0; // SLT
            default: ALUResult = 32'b0;                    // Default to zero
        endcase
    end

    // Zero is 1 if ALUResult is exactly 0
    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;

endmodule
