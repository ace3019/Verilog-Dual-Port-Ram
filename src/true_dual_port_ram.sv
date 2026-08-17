module ram_true_dual_port2(
    output reg [7:0] q_a, q_b,
    input  [7:0] data_a, data_b,
    input  [5:0] addr_a, addr_b,
    input        we_a, we_b,
    input        clk
);

    reg [7:0] ram [63:0];

    // Port A
    always @(posedge clk) begin
        if (we_a)
            ram[addr_a] <= data_a;

        q_a <= ram[addr_a];
    end

    // Port B
    always @(posedge clk) begin
        if (we_b)
            ram[addr_b] <= data_b;

        q_b <= ram[addr_b];
    end

endmodule
