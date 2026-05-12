// parameterized N bit wallace tree multiplier (Not implemented. Skipped for prefrence to DSP mapping infered by *)

module parameterized_wallace_multiplier #(parameter N = 16)(
    input logic [N-1:0] x, y,
    output logic [2*N-1:0] p
);

localparam ROUNDS = $clog2(N);
localparam ROWS = N;

// 3D array: [round][row][bit position]
logic [2*N-1:0] tree [ROUNDS:0][ROWS-1:0];

genvar i, j;
generate
    for(i = 0; i < N; i++) begin : pp_rows
        for (j = 0; j < N; j++) begin: pp_cols
            assign tree[0][i][i+j] = x[i] & y[j];
        end
    end
endgenerate

genvar round, r, k;
generate
    for(round = 1; round < ROUNDS; round++) begin : round
        for(k = 0; k < )
        full_adder u (.x(tree[round][r][k]), .y(tree[round][r+1][k]), .cin(tree[round][r+2][k])))
            
        end
    end
endgenerate

endmodule
