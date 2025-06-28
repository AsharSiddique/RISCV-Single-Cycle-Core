module RegisterFile (
    input  wire        CLK,
    input  wire [4:0]  A1, A2, A3,
    input  wire [31:0] WD3,
    input  wire        WE3,
    output wire [31:0] RD1, RD2
);

    // Register file: 32 registers of 32 bits each
    reg [31:0] regfile [0:31];

    // Combinational reads
    assign RD1 = regfile[A1];
    assign RD2 = regfile[A2];

    // Synchronous write on clock edge
    always @(posedge CLK) begin
        if (WE3)
            regfile[A3] <= WD3;
    end

endmodule
