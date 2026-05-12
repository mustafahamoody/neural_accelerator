// Relu Unit for Neural Accelerator

module relu_unit #(parameter BIT_WIDTH = 16, MAC_CYCLES = 784)(
    input logic signed [2*BIT_WIDTH-1 + $clog2(MAC_CYCLES) : 0] in,
    output logic signed [2*BIT_WIDTH-1 + $clog2(MAC_CYCLES) : 0] out
);

    always_comb begin : relu
        
        if (in < 0) begin
            out = 0; 
        end
        else begin
            out = in; 
        end
    end

endmodule