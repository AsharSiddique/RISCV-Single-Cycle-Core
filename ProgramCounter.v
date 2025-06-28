module ProgramCounter (
    input  wire        CLK,
    input  wire [31:0] PCNext,
    output reg  [31:0] PC
);

    initial begin
        PC = 0; // Ensure PC starts at 0
    end

    always @(posedge CLK) begin
        PC <= PCNext;
    end

endmodule
