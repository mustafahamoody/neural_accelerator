// 4 bit ripple carry adder

module ripple_carry_adder #(parameter N = 4)( 
    input logic [N-1:0] x, y,
    input logic cin,
    output logic [N-1:0] sum,
    output logic cout
);

    logic c0, c1, c2;

full_adder u0 (
    .x(x[0]), .y(y[0]), .cin(cin), .sum(sum[0]), .cout(c0)
);

full_adder u1 (
    .x(x[1]), .y(y[1]), .cin(c0), .sum(sum[1]), .cout(c1)
);

full_adder u2 (
    .x(x[2]), .y(y[2]), .cin(c1), .sum(sum[2]), .cout(c2)
);

full_adder u3 (
    .x(x[3]), .y(y[3]), .cin(c2), .sum(sum[3]), .cout(cout)
);

endmodule