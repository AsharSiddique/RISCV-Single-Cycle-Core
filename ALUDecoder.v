module ALUDecoder (
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire       opb5,
    input  wire       funct7b5,
    output reg  [2:0] ALUControl
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000;  // lw, sw -> add
            2'b01: ALUControl = 3'b001;  // beq     -> subtract
            2'b10: begin
                case (funct3)
                    3'b010: ALUControl = 3'b101; // slt
                    3'b110: ALUControl = 3'b011; // or
                    3'b111: ALUControl = 3'b010; // and
                    3'b000: begin
                        if (opb5 && funct7b5)
                            ALUControl = 3'b001; // sub
                        else
                            ALUControl = 3'b000; // add
                    end
                    default: ALUControl = 3'bxxx; // undefined
                endcase
            end
            default: ALUControl = 3'bxxx; // undefined
        endcase
    end

endmodule
