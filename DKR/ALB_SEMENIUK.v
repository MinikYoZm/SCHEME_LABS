`timescale 1ns / 1ps

module ALB_SEMENIUK (
    input [3:0] R,
    input [3:0] S,
    input CI,
    input [2:0] H,
    input [1:0] I,
    output reg [3:0] F,
    output reg [3:0] F_norm,
    output reg CO,
    output reg VO,
    output NO,
    output ZO
);

    wire [4:0] diff_res = R - S - 1 + CI;
    wire [4:0] sum_res  = R + S + CI;
    wire [3:0] and_res  = R & S;
    wire [3:0] or_res   = R | S;

    always @(*) begin
        if (H == 3'b011) begin
            case (I)
                2'b11: begin
                    F  = or_res;
                    CO = 0;
                    VO = 0;
                end
                2'b10: begin
                    F  = sum_res[3:0];
                    CO = sum_res[4];
                    VO = (R[3] == S[3]) && (F[3] != R[3]);
                end
                2'b01: begin
                    F  = and_res;
                    CO = 0;
                    VO = 0;
                end
                2'b00: begin
                    F  = diff_res[3:0];
                    CO = diff_res[4];
                    VO = (R[3] != S[3]) && (F[3] != R[3]);
                end
                default: begin
                    F  = 4'b0000;
                    CO = 0;
                    VO = 0;
                end
            endcase
        end else begin
            F  = 4'b0000;
            CO = 0;
            VO = 0;
        end
    end

    always @(*) begin
        if (F[3] != F[2])
            F_norm = {F[3], F[3:1]};
        else
            F_norm = F;
    end

    assign NO = F[3];
    assign ZO = ~|F;

endmodule