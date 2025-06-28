`timescale 1ns / 1ps

module Top_mixed_tb;

    reg CLK;
    integer i;

    Top uut (
        .CLK(CLK)
    );

    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    initial begin
        // Clear registers
        for (i = 0; i < 32; i = i + 1)
            uut.RF.regfile[i] = 0;

        // ==== Mixed Instruction Program ====

        // 1. addi x1, x0, 5
        uut.IM.memory[0] = {12'd5, 5'd0, 3'b000, 5'd1, 7'b0010011};

        // 2. addi x2, x0, 7
        uut.IM.memory[1] = {12'd7, 5'd0, 3'b000, 5'd2, 7'b0010011};

        // 3. add x3, x1, x2
        uut.IM.memory[2] = 32'b0000000_00010_00001_000_00011_0110011;

        // 4. sub x4, x3, x1
        uut.IM.memory[3] = 32'b0100000_00001_00011_000_00100_0110011;

        // 5. and x5, x1, x2
        uut.IM.memory[4] = 32'b0000000_00010_00001_111_00101_0110011;

        // 6. or x6, x1, x2
        uut.IM.memory[5] = 32'b0000000_00010_00001_110_00110_0110011;

        // 7. slt x7, x1, x2
        uut.IM.memory[6] = 32'b0000000_00010_00001_010_00111_0110011;

        // 8. sw x3, 0(x0)
        uut.IM.memory[7] = {7'd0, 5'd3, 5'd0, 3'b010, 5'd0, 7'b0100011};

        // 9. lw x8, 0(x0)
        uut.IM.memory[8] = {12'd0, 5'd0, 3'b010, 5'd8, 7'b0000011};

        // 10. beq x1, x1, +8 (offset = 8 -> skip next)
        uut.IM.memory[9] = 32'b0000000_00001_00001_000_01000_1100011;

        // 11. addi x9, x0, 99 (should be skipped)
        uut.IM.memory[10] = {12'd99, 5'd0, 3'b000, 5'd9, 7'b0010011};

        // 12. addi x10, x0, 123
        uut.IM.memory[11] = {12'd123, 5'd0, 3'b000, 5'd10, 7'b0010011};

        // 13. addi x11, x0, 222
        uut.IM.memory[13] = {12'd222, 5'd0, 3'b000, 5'd11, 7'b0010011};

        // 14. addi x12, x0, 555
        uut.IM.memory[14] = {12'd555, 5'd0, 3'b000, 5'd12, 7'b0010011};

        // Wait for execution to complete
        #400;

        $display("\n==== Register File Dump ====");
        for (i = 0; i < 32; i = i + 1)
            $display("x%0d = %0d", i, uut.RF.regfile[i]);

        $display("\n==== Data Memory Check ====");
        $display("MEM[0] = %0d", uut.DM.memory[0]);

        $finish;
    end

    initial begin
        $dumpfile("waveform_mixed.vcd");
        $dumpvars(0, Top_mixed_tb);
    end

endmodule
