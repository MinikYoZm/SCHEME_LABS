`timescale 1ns / 1ps

module TB_ALB_SEMENIUK;

    reg [3:0] R, S;
    reg CI;
    reg [2:0] H;
    reg [1:0] I;

    wire [3:0] F, F_norm;
    wire CO, VO, NO, ZO;

    ALB_SEMENIUK uut (
        .R(R), .S(S), .CI(CI), .H(H), .I(I),
        .F(F), .F_norm(F_norm),
        .CO(CO), .VO(VO), .NO(NO), .ZO(ZO)
    );

    task check;
        input [3:0] r, s;
        input ci;
        input [1:0] i;
        input [63:0] op_name;
        begin
            R = r; S = s; CI = ci; I = i; #10;
            $display("%s: R=%b S=%b CI=%b => F=%b F_norm=%b CO=%b VO=%b NO=%b ZO=%b",
                op_name, R, S, CI, F, F_norm, CO, VO, NO, ZO);
        end
    endtask

    initial begin
        H = 3'b011;

        $display("=== ALB_MI=00: R - S - 1 + CI ===");
        check(4'b0110, 4'b0011, 1, 2'b00, "SUB");
        check(4'b1001, 4'b0100, 0, 2'b00, "SUB");
        check(4'b0001, 4'b1110, 1, 2'b00, "SUB");
        check(4'b0000, 4'b0000, 1, 2'b00, "SUB");

        $display("=== ALB_MI=01: R & S ===");
        check(4'b1101, 4'b0111, 0, 2'b01, "AND");
        check(4'b1010, 4'b1100, 0, 2'b01, "AND");
        check(4'b1111, 4'b0000, 0, 2'b01, "AND");
        check(4'b1011, 4'b1011, 0, 2'b01, "AND");

        $display("=== ALB_MI=10: R + S + CI ===");
        check(4'b0110, 4'b0011, 1, 2'b10, "ADD");
        check(4'b0111, 4'b0111, 0, 2'b10, "ADD");
        check(4'b1001, 4'b1001, 0, 2'b10, "ADD");
        check(4'b0000, 4'b0000, 0, 2'b10, "ADD");

        $display("=== ALB_MI=11: R | S ===");
        check(4'b0101, 4'b1000, 0, 2'b11, "OR ");
        check(4'b1100, 4'b0011, 0, 2'b11, "OR ");
        check(4'b0000, 4'b0000, 0, 2'b11, "OR ");
        check(4'b1111, 4'b1111, 0, 2'b11, "OR ");

        $display("=== Incorrect H - variant ===");
        H = 3'b000;
        check(4'b0110, 4'b0011, 1, 2'b10, "INV");

        $stop;
    end

endmodule

