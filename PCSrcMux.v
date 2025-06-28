module PCSrcMux (
    input  wire        PCSrc,
    input  wire [31:0] PCPlus4,
    input  wire [31:0] PCTarget,
    output wire [31:0] PCNext
);

    assign PCNext = (PCSrc == 1'b0) ? PCPlus4 : PCTarget;

endmodule
