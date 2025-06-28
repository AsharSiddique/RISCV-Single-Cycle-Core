module DataMemory (
    input  wire        CLK,
    input  wire        WE,
    input  wire [31:0] A,    // Byte address
    input  wire [31:0] WD,   // Write data
    output wire [31:0] RD    // Read data
);

    reg [31:0] memory [0:255];  // 1024 bytes = 256 words of 32-bit each

    // Read is combinational
    assign RD = memory[A[9:2]];  // Word-aligned access

    // Write on rising edge if WE is enabled
    always @(posedge CLK) begin
        if (WE)
            memory[A[9:2]] <= WD;
    end

endmodule
