module MainDecoder (
    input  [6:0] op,
    output reg Branch,
    output reg ResultSrc,
    output reg MemWrite,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegWrite,
    output reg [1:0] ALUOp
);

    always @(*) begin
        // Default control values
        Branch    = 1'b0;
        ResultSrc = 1'b0;
        MemWrite  = 1'b0;
        ALUSrc    = 1'b0;
        ImmSrc    = 2'b00;
        RegWrite  = 1'b0;
        ALUOp     = 2'b00;

        case (op)
            7'b0000011: begin // lw
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00;
                ALUSrc    = 1'b1;
                MemWrite  = 1'b0;
                ResultSrc = 1'b1;
                Branch    = 1'b0;
                ALUOp     = 2'b00;
            end

            7'b0100011: begin // sw
                RegWrite  = 1'b0;
                ImmSrc    = 2'b01;
                ALUSrc    = 1'b1;
                MemWrite  = 1'b1;
                ResultSrc = 1'b0;  // Don't care in real logic, safe to set 0
                Branch    = 1'b0;
                ALUOp     = 2'b00;
            end

            7'b0110011: begin // R-type (add, sub, etc.)
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00;  // Not used, safe value
                ALUSrc    = 1'b0;
                MemWrite  = 1'b0;
                ResultSrc = 1'b0;
                Branch    = 1'b0;
                ALUOp     = 2'b10;
            end

            7'b1100011: begin // beq
                RegWrite  = 1'b0;
                ImmSrc    = 2'b10;
                ALUSrc    = 1'b0;
                MemWrite  = 1'b0;
                ResultSrc = 1'b0;  // Don't care in real logic, safe to set 0
                Branch    = 1'b1;
                ALUOp     = 2'b01;
            end

            7'b0010011: begin // addi
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00;
                ALUSrc    = 1'b1;
                MemWrite  = 1'b0;
                ResultSrc = 1'b0;
                Branch    = 1'b0;
                ALUOp     = 2'b10;
            end

            default: begin
                // Default control signals already set above
            end
        endcase
    end
endmodule
