`timescale 1ns / 1ps

module Control_Dev_Semeniuk();
    reg Clk;
    reg reset;
    reg X;
    reg [2:0] MI; 
    parameter a1 = 2'b00;
    parameter a2 = 2'b01;
    parameter a3 = 2'b10;
    reg [1:0] current, next;

    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk;
    end

    initial begin
        reset = 1; X = 0;      
        #12 reset = 0;
        #20 X = 1;
        #30 X = 0;
        #40 $stop;
    end

    always @(posedge Clk or posedge reset) begin
        if (reset)
            current <= a1;
        else
            current <= next;
    end

    always @(*) begin
        case (current)
            a1: next = a2;
            a2: next = a3;
            a3: begin
                if (X == 1'b1)
                    next = a2;
                else
                    next = a1;
            end
            default: next = a1;
        endcase
    end
    always @(*) begin
        case (current)
            a1: MI = 3'b010; // Y2
            a2: MI = 3'b100; // Y1
            a3: MI = 3'b011; // Y2, Y3
            default: MI = 3'b000;
        endcase
    end
endmodule
