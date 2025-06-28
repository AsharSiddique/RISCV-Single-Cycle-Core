`timescale 1ns / 1ps

module Top_tb;

    reg CLK;
    integer i;

    // Instantiate Top module
    Top uut (
        .CLK(CLK)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #30 CLK = ~CLK; // 10ns clock (100MHz)
    end

    // Stimulus
    initial begin
        // Initialize register file with values
        for (i = 0; i < 32; i = i + 1)
            uut.RF.regfile[i] = i;

        // ==== R-Type Instructions ====

        // ADD x5, x1, x2  => x5 = x1 + x2 = 3
        uut.IM.memory[0] = 32'b0000000_00010_00001_000_00101_0110011;

        // SUB x6, x3, x4  => x6 = x3 - x4 = -1 (0xFFFFFFFF)
        uut.IM.memory[1] = 32'b0100000_00100_00011_000_00110_0110011;

        // AND x7, x5, x6  => x7 = x5 & x6
        uut.IM.memory[2] = 32'b0000000_00110_00101_111_00111_0110011;

        // OR x8, x1, x6   => x8 = x1 | x6
        uut.IM.memory[3] = 32'b0000000_00110_00001_110_01000_0110011;

        // SLT x9, x1, x2  => x9 = (x1 < x2) ? 1 : 0
        uut.IM.memory[4] = 32'b0000000_00010_00001_010_01001_0110011;

        // ==== I-Type Instructions ====

        // ADDI x10, x1, 10 => x10 = x1 + 10 = 11
        uut.IM.memory[5] = { 12'd10, 5'd1, 3'b000, 5'd10, 7'b0010011 };

        // ANDI x11, x1, 15 => x11 = x1 & 15 = 1
        uut.IM.memory[6] = { 12'd15, 5'd1, 3'b111, 5'd11, 7'b0010011 };

        // ORI x12, x1, 8   => x12 = x1 | 8 = 9
        uut.IM.memory[7] = { 12'd8, 5'd1, 3'b110, 5'd12, 7'b0010011 };

        // SLTI x13, x1, 3  => x13 = (x1 < 3) ? 1 : 0
        uut.IM.memory[8] = { 12'd3, 5'd1, 3'b010, 5'd13, 7'b0010011 };

        // ==== S-Type Instruction ====

        // SW x2, 0(x1) => MEM[x1 + 0] = x2
        uut.IM.memory[9] = { 7'd0, 5'd2, 5'd1, 3'b010, 5'd0, 7'b0100011 };

        // ==== Load Instruction ====

        // LW x14, 0(x1) => x14 = MEM[x1 + 0]
        uut.IM.memory[10] = { 12'd0, 5'd1, 3'b010, 5'd14, 7'b0000011 };

        // ==== B-Type Instruction ====

        // BEQ x1, x1, +8 => if x1 == x1, skip next instruction
        uut.IM.memory[11] = 32'b0000000_00001_00001_000_01000_1100011;

        // ADDI x15, x0, 99 => x15 = 99 (should be skipped if branch works)
        uut.IM.memory[12] = { 12'd99, 5'd0, 3'b000, 5'd15, 7'b0010011 };

        // ADDI x16, x0, 123 => x16 = 123
        uut.IM.memory[13] = { 12'd123, 5'd0, 3'b000, 5'd16, 7'b0010011 };

        // Wait enough time for all instructions to complete
        #900;

        // ==== Output Register File ====
        $display("\n==== Register File Dump ====");
        for (i = 0; i < 32; i = i + 1)
            $display("x%0d = %0d", i, uut.RF.regfile[i]);

        // ==== Data Memory Check ====
        $display("\n==== Data Memory Check ====");
        $display("MEM[%0d] = %0d", uut.RF.regfile[1], uut.DM.memory[uut.RF.regfile[1] >> 2]);

        $finish;
    end

    // Dump waveform for GTKWave
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, Top_tb);
    end

endmodule
