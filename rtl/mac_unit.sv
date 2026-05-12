// Single MAC Unit for Neural Accelerator

module mac_unit #(parameter BIT_WIDTH = 16, MAC_CYCLES = 784)(
    input logic signed [BIT_WIDTH-1:0] w, x,
    input logic clk, en, rst, clr,
    output logic signed [2*BIT_WIDTH-1 + $clog2(MAC_CYCLES) : 0] out  // 2N-1 Output bits needed + log2(mac_cycles) padding needed for addiion carry.
);

    logic signed [2*BIT_WIDTH-1 + $clog2(MAC_CYCLES) : 0] acc; 

    always_ff @(posedge clk) begin : multiply_accumulate_loop
        if (rst) begin // Reset acc to 0 (On start/Reset) 
            acc <= 0;
        end
        else if (en) begin // Check enable signal to start MAC operation
            if (clr) begin // Set acc to w * x (Transition to next layer without lossing clock cycle to clear)
                acc <= w * x;
            end
            else begin
                acc <= acc + w * x; // Normal mac operation accumulate += w * x (dot product for w_n * x_n)
            end
        end
    end

    assign out = acc;
    
endmodule