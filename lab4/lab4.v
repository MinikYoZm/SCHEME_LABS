module Ex2_semeniuk_comb (
    input wire x1,
    input wire x2,
    input wire x3,
    output wire y_nand,
    output wire y_nor
);
    assign y_nand = ~( 
        ~(~x3 & ~x2 & ~x1) &
        ~(~x3 & ~x2 &  x1) &
        ~(~x3 &  x2 &  x1) &
        ~( x3 & ~x2 &  x1)
    );
    assign y_nor = ~( 
        ~( x3 | ~x2 |  x1) |
        ~(~x3 |  x2 |  x1) |
        ~(~x3 | ~x2 |  x1) |
        ~(~x3 | ~x2 | ~x1)
    );
endmodule
