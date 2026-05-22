// Mac Array for Neural Accelerator : Instintating Muliple MAC Units in an Array for Parallel Computation

module mac_array #(parameter BIT_WIDTH = 16, INPUT_WIDTH = 784, MAC_UNITS = 64) ( // MAC Units = # hidden neurons in first layer? (or arbitrary big number that fpga can handle )
    input logic signed [BIT_WIDTH-1:0] x,
    input logic signed [MAC_UNITS-1:0][BIT_WIDTH-1:0] w,
    input logic clk, en, rst, clr,
    output logic signed [MAC_UNITS-1:0][2*BIT_WIDTH-1 + $clog2(INPUT_WIDTH) : 0] out
);
    genvar unit;
    generate
        for (unit = 0; unit < MAC_UNITS; unit++) begin: mac_instances
        // Instantiate MAC and override its default parameters
            mac_unit #(.BIT_WIDTH(BIT_WIDTH), .MAC_CYCLES(INPUT_WIDTH)) 
            single_mac_unit (.w(w[unit]), .x(x), .clk(clk), .en(en), .rst(rst), .clr(clr), .out(out[unit]));
        end
    endgenerate

endmodule