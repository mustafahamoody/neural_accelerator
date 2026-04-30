// parameterized_cla testbench

`timescale 1ns/1ps

module tb_parameterized_cla;

    logic [15:0] a, b, sum;
    logic cin, cout;

    parameterized_cla #(16) dut (.x(a), .y(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        a = 16'b0000000000000000; b = 16'b0000000000000000; cin = 1'b0; // Expected 0000000000000000, cout 0
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        
        a = 16'b0000000000000001; b = 16'b0000000000000001; cin = 1'b0; // Expected 0000000000000010, cout 0
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        
        a = 16'b0101010101010101; b = 16'b0010101010101011; cin = 1'b1; // Expected 1000000000000001, cout 0
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);

        a = 16'b1111111111111111; b = 16'b0000000000000001; cin = 1'b0; // Expected 0000000000000000, cout 1
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);

        $finish;
    end

endmodule