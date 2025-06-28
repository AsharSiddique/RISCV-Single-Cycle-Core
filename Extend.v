module Extend (
    input  wire [31:7] Instr,
    input  wire [1:0]  ImmSrc,
    output reg  [31:0] ImmExt
);

    always @(*) begin
        case (ImmSrc)
            2'b00: begin // I-type: lw, addi
                ImmExt = {{20{Instr[31]}}, Instr[31:20]};
            end
            2'b01: begin // S-type: sw
                ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
            end
            2'b10: begin // B-type: beq
                ImmExt = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
            end
            default: begin
                ImmExt = 32'bx; // undefined
            end
        endcase
    end

endmodule
