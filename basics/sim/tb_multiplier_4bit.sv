// 4 bit multiplier testbench

`timescale 1ns/1ps

module tb_multiplier;

    logic [3:0] a, b;
    logic [7:0] product;

    multiplier_4bit dut (.x(a), .y(b), .p(product));

    initial begin
         a = 4'b0000; b = 4'b0000; // Expected 00000000
        #10;
        $display("a=%b, b=%b, product=%b", a, b, product);
        
        a = 4'b1111; b = 4'b1111; // Expected 11100001
        #10;
        $display("a=%b, b=%b, product=%b", a, b, product);
        
        a = 4'b1001; b = 4'b0110; // Expected 0110110
        #10;
        $display("a=%b, b=%b, product=%b", a, b, product);

        a = 4'b1111; b = 4'b0000; // Expected 00000000
        #10;
        $display("a=%b, b=%b, product=%b", a, b, product);

        $finish;
    end

endmodule