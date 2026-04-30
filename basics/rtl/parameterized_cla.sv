// parameterized N bit carry lookahead adder

module parameterized_cla #(parameter N = 16)(
    input logic [N-1:0] x, y,
    input logic cin,
    output logic [N-1:0] sum,
    output logic cout
);

    logic [N:0] c; // c[0] is cin, c[N] is cout 
    logic [N-1:0] g, p; 
    logic running; // running "and" of propegates in loop

    // Generate and propegate logic for CLA
    assign g = x & y;
    assign p = x ^ y;

    // Calculate N carries for N bit cla
    always_comb begin : carry_calc

        c[0] = cin; // assign c[0] = cin (since loop runs for i >= 1)

        for (integer i = 1; i <= N; i++) begin
            c[i] = 1'b0; // Need to preset current c to 0 to use or= in loop
            running = 1'b1; // Need to preset running to 1 to use and= in loop

            for (integer j = i - 1; j >= 0; j--) begin
                c[i] |= g[j] & running;
                running &= p[j];
            end

            c[i] |= running & cin;
        end 
    end

    assign cout = c[N];

    // Generate N adders for N bit cla
    generate
        for (genvar i = 0; i < N; i++) begin: adders 
            full_adder u (.x(x[i]), .y(y[i]), .cin(c[i]), .sum(sum[i]), .cout());
        end
    endgenerate

endmodule
