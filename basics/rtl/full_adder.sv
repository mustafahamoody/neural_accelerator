//full adder

module full_adder (
    input logic x, y, cin,
    output logic sum, cout
);

assign sum = x ^ y ^ cin;
assign cout = x & y | cin & (x ^ y);

endmodule