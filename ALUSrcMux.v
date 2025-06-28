module ALUSrcMux (
    input  wire        ALUSrc,
    input  wire [31:0] RD2,
    input  wire [31:0] ImmExt,
    output wire [31:0] SrcB
);

    assign SrcB = (ALUSrc == 1'b0) ? RD2 : ImmExt;

endmodule
