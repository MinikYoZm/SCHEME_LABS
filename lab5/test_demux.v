`timescale 1ns / 1ps

module tb_demux_1_to_5;

    reg [3:0] D;
    reg [2:0] sel;
    
    wire [3:0] Q0, Q1, Q2, Q3, Q4;

    demux_1_to_5_4bit uut (
        .D(D), 
        .sel(sel), 
        .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3), .Q4(Q4)
    );

    initial begin
      
        D = 4'b0101; 
        
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10; 
        $stop;
    end

endmodule