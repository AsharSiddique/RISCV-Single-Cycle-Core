module ResultSrcMux (
    input  wire        ResultSrc,
    input  wire [31:0] ALUResult,
    input  wire [31:0] RD,
    output wire [31:0] Result
);

    assign Result = (ResultSrc == 1'b0) ? ALUResult : RD;

endmodule
