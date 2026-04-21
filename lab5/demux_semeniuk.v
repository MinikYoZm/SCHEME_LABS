module demux_1_to_5_4bit (
    input wire [3:0] D,
    input wire [2:0] sel,
    output reg [3:0] Q0,
    output reg [3:0] Q1,
    output reg [3:0] Q2,
    output reg [3:0] Q3,
    output reg [3:0] Q4
);
    always @(*) begin
        Q0 = 4'b0000;
        Q1 = 4'b0000;
        Q2 = 4'b0000;
        Q3 = 4'b0000;
        Q4 = 4'b0000;
        case (sel)
            3'b000: Q0 = D;
            3'b001: Q1 = D;
            3'b010: Q2 = D;
            3'b011: Q3 = D;
            3'b100: Q4 = D;
            default: ;
        endcase
    end
endmodule
