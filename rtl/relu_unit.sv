// Relu Unit for Neural Accelerator - Applizes ReLU activation to the output of MAC, and quantizes output back to BIT_WIDTH 

module relu_unit #(parameter BIT_WIDTH = 16, MAC_CYCLES = 784, SHIFT_AMT = 4)( // Shift amount needs to determine from acutal 42-bit accumulated sums for each layer and passed in as a param to ensure majority of neurons not clamped
    input logic signed [2*BIT_WIDTH-1 + $clog2(MAC_CYCLES) : 0] in,
    output logic signed [BIT_WIDTH-1 : 0] out
);
    localparam signed [BIT_WIDTH - 1: 0] MAX_VALUE = {1'b0, {(BIT_WIDTH-1){1'b1}}}; // Max value to clamp to after quantization if value exceeds Max possible BIT_WIDTH value. 

    always_comb begin : relu
        logic signed [2*BIT_WIDTH-1 - SHIFT_AMT + $clog2(MAC_CYCLES) : 0] scaled_in; // Shifted input for quantization
        
        if (in < 0) begin
            out = '0; 
        end
        else begin
            scaled_in = in >>> SHIFT_AMT; // Quantization by right shifting (Dividing by 2^SHIFT_AMT)
            if (scaled_in > MAX_VALUE) begin // Clamps output to max value 
                scaled_in = MAX_VALUE;
            end
            out = scaled_in[BIT_WIDTH-1:0];
        end
    end

endmodule