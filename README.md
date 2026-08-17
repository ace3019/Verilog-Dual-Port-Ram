# True Dual-Port RAM (Verilog)

A synthesizable 64 x 8-bit, single-clock true dual-port RAM implementation.

## Interface
                    ┌─────────────────────┐
       Port A       │                     │
 data_a ───────────►│                     │──► q_a
 addr_a ───────────►│      64 × 8 RAM     │
 we_a ─────────────►│                     │
                    │                     │
       Port B       │                     │
 data_b ───────────►│                     │──► q_b
 addr_b ───────────►│                     │
 we_b ─────────────►│                     │
                    │                     │
 clk ──────────────►│                     │
                    └─────────────────────┘
Each port has its own address, write enable, data input, and data output. Both ports operate on the rising edge of the same clock.

| Signal | Description |
| --- | --- |
| `addr_a`, `addr_b` | 6-bit addresses for ports A and B |
| `we_a`, `we_b` | Active-high write enables |
| `data_a`, `data_b` | 8-bit write data |
| `q_a`, `q_b` | 8-bit registered read data |

## Behavior

- A write port uses **read-first** behavior: its output receives the value stored at the addressed location before that clock edge's write.
- A port without write enabled still performs a synchronous read.
- If both ports write the same address on one edge, the resulting stored value is device/tool dependent; avoid that condition in the design.

## Layout

```
src/true_dual_port_ram.sv  Synthesizable RAM module
tb/true_dual_port_ram_tb.sv Basic simulation testbench
```

## Simulating with Icarus Verilog

```powershell
iverilog -g2012 -o simv src/true_dual_port_ram.sv tb/true_dual_port_ram_tb.sv
vvp simv
```

The testbench writes and reads through both ports, including concurrent access to different addresses.
