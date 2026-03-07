// ripple adder testbench

`timescale 1ns/1ps

module tb_ripple_carry_adder;

    logic [3:0] a, b;
    logic cin;
    logic [3:0] sum;
    logic cout;

    ripple_carry_adder dut (
        .x(a), .y(b), .cin(cin), .sum(sum), .cout(cout)
    );

    initial begin
        a = 4'b0000; b = 4'b0000; cin = 1'b0; // Expected 0
        #10;
        $display("a=%b b=%b, sum=%b, cout=%b", a, b, sum, cout);

        a = 4'b0010; b = 4'b0110; cin = 1'b1; // Expected 1001
        #10;
        $display("a=%b b=%b, sum=%b, cout=%b", a, b, sum, cout);

        a = 4'b1111; b = 4'b0001; cin = 1'b0; // Expected 0001, cout 1
        #10;
        $display("a=%b b=%b, sum=%b, cout=%b", a, b, sum, cout);


        $finish;
    end

endmodule