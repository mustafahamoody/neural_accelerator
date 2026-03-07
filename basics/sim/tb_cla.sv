// cla testbench

`timescale 1ns/1ps

module tb_cla;

    logic [3:0] a, b, sum;
    logic cin, cout;

    cla dut (.x(a), .y(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        a = 4'b0000; b = 4'b0000; cin = 1'b0; // Expected 0000
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        
        a = 4'b0001; b = 4'b0001; cin = 1'b0; // Expected 0010
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
        
        a = 4'b0010; b = 4'b0101; cin = 1'b1; // Expected 1000
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);

        a = 4'b1111; b = 4'b0001; cin = 1'b0; // Expected 0001, cout 1
        #10;
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);

        $finish;
    end

endmodule