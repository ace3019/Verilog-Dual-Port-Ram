`timescale 1ns/1ps

module true_dual_port_ram_tb;
    logic       clk = 1'b0;
    logic [5:0] addr_a, addr_b;
    logic       we_a, we_b;
    logic [7:0] data_a, data_b;
    logic [7:0] q_a, q_b;

    true_dual_port_ram dut (.*);

    always #5 clk = ~clk;

    initial begin
        addr_a = '0; addr_b = '0;
        we_a = 1'b0; we_b = 1'b0;
        data_a = '0; data_b = '0;

        // Concurrent writes to different locations.
        @(negedge clk);
        addr_a = 6'd3;  data_a = 8'hA5; we_a = 1'b1;
        addr_b = 6'd12; data_b = 8'h3C; we_b = 1'b1;

        // Synchronously read both stored values.
        @(negedge clk);
        we_a = 1'b0; we_b = 1'b0;
        @(posedge clk); #1;
        assert (q_a === 8'hA5) else $fatal(1, "Port A read failed: %h", q_a);
        assert (q_b === 8'h3C) else $fatal(1, "Port B read failed: %h", q_b);

        $display("PASS: true dual-port RAM test completed");
        $finish;
    end
endmodule
