// 4 bit carry lookahead adder

module cla #(parameter N = 4)(
    input logic [N-1:0] x, y,
    input logic cin,
    output logic [N-1:0] sum,
    output logic cout
);

    logic [N-1:0] g, p;
    logic c1, c2, c3, c4;

    assign g = x & y;
    assign p = x ^ y;

    assign c1 = g[0] | (p[0] & cin);
    assign c2 = g[1] | (g[0] & p[1]) | (p[1] & p[0] & cin);
    assign c3 = g[2] | (g[1] & p[2]) | (g[0] & p[2] & p[1]) | (p[2] & p[1] & p[0] & cin);
    assign cout = g[3] | (g[2] & p[3]) | (g[1] & p[3] & p[2]) | (g[0] & p[3] & p[2] & p[1]) | (p[3] & p[2] & p[1] & p[0] & cin);

    full_adder u0 (.x(x[0]), .y(y[0]), .cin(cin), .sum(sum[0]), .cout());
    full_adder u1 (.x(x[1]), .y(y[1]), .cin(c1), .sum(sum[1]), .cout());
    full_adder u2 (.x(x[2]), .y(y[2]), .cin(c2), .sum(sum[2]), .cout());
    full_adder u3 (.x(x[3]), .y(y[3]), .cin(c3), .sum(sum[3]), .cout());

endmodule