// 4 bit multiplier -- Using CLA for sum of partial products

module multiplier_4bit #(parameter N = 4)(
    input logic [N-1:0] x, y, 
    output logic [7:0] p
);

    logic [3:0] pp0, pp1, pp2, pp3;   // internal Signals for partial products

    logic [3:0] s; // stage 1 sum bits s1-s4
    logic [4:0] t; // stage 2 sum bits t2-t6

    logic c4, e6, j3;    // internal Signals carry from stage 1, 2, 3 resp.
    logic [3:0] u3_sum;  // handles extra bits from chaining two 4 bit clas


    //Partial products 
    assign pp0 = {4{x[0]}} & y;
    assign pp1 = {4{x[1]}} & y;
    assign pp2 = {4{x[2]}} & y;
    assign pp3 = {4{x[3]}} & y;

    // Stage 1: Adding Partial Products pp0 and pp1
    assign p[0] = pp0[0];

    cla u0(
        .x({1'b0, pp0[3:1]}), .y(pp1), .cin(1'b0), .sum(s), .cout(c4)
    );

    assign p[1] = s[0];

    // Stage 2: Adding Partial Products pp2 and pp3
    assign t[0] = pp2[0];

    cla u1(
        .x({1'b0, pp2[3:1]}), .y(pp3), .cin(1'b0), .sum(t[4:1]), .cout(e6)
    );

    // Stage 3: Adding stage 1 and stage 2
    cla u2(
        .x({c4, s[3:1]}), .y(t[3:0]), .cin(1'b0), .sum(p[5:2]), .cout(j3)
    );
    cla u3(
        .x(4'b0), .y({2'b0, e6, t[4]}), .cin(j3), .sum(u3_sum), .cout()
    );

    assign p[7:6] = u3_sum[1:0];   // Only need first 2 values from cla u3


endmodule

    