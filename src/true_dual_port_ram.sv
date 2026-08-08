`timescale 1ns/1ps

/// 64-word by 8-bit true dual-port synchronous RAM.
///
/// Each port has a registered (one-cycle latency) read output. On a write,
/// the output captures the location's old contents (read-first behavior).
module true_dual_port_ram (
    input  logic       clk,
    input  logic [5:0] addr_a,
    input  logic [5:0] addr_b,
    input  logic       we_a,
    input  logic       we_b,
    input  logic [7:0] data_a,
    input  logic [7:0] data_b,
    output logic [7:0] q_a,
    output logic [7:0] q_b
);
    logic [7:0] mem [0:63];

    always_ff @(posedge clk) begin
        q_a <= mem[addr_a];
        if (we_a)
            mem[addr_a] <= data_a;

        q_b <= mem[addr_b];
        if (we_b)
            mem[addr_b] <= data_b;
    end
endmodule
