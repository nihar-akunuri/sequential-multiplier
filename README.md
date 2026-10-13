# Sequential Signed Multiplier in Verilog

This project implements an iterative multiplier with signed 8-bit operands and a 16-bit product output. Rather than calculating the entire product in one combinational expression, the RTL processes multiplier bits over multiple clock cycles and signals completion with `done`.

## Design overview

The main module is `seq_mult`.

| Signal | Direction | Width | Description |
|---|---|---:|---|
| `clk` | Input | 1 | Clock for the iterative operation. |
| `start` | Input | 1 | Starts/reinitializes a multiplication. |
| `a` | Input | 8 | Signed operand A. |
| `b` | Input | 8 | Signed operand B. |
| `p` | Output | 16 | Signed product result. |
| `done` | Output | 1 | Indicates that the iteration has completed. |

The RTL uses a counter to process multiplier bits and accumulates shifted partial products in the result register. The operation is intended to complete after processing the eight operand bits.

## Files

| File | Purpose |
|---|---|
| `seq_mult.v` | Iterative signed multiplier datapath and control counter. |
| `tb_seqmul.v` | Testbench with a reference expression (`a * b`), timeout handling, and result comparisons. |

## Test scenarios

The supplied testbench includes examples covering:
- Positive operands.
- Negative operands.
- Zero operands.
- Larger positive values, including a product that exceeds the range of an 8-bit result.

The testbench displays `PASS` when no mismatches or timeouts are recorded, otherwise it reports failure details. Run the testbench to confirm behavior for the current RTL; the documented scenarios should not be interpreted as a guarantee that all signed corner cases pass.

## Simulation

Compile `seq_mult.v` with `tb_seqmul.v` and select `seq_mult_tb` as the simulation top. The testbench generates a 10-time-unit clock period and waits for `done`, with a timeout of 100 cycles.

## Possible improvements

- Add directed tests for the minimum signed value (-128), maximum value (127), and all sign combinations.
- Verify behavior when `start` is asserted during an active multiplication.
- Add randomized tests and coverage for operand ranges and completion latency.

## Tools

- Verilog HDL
- Event-driven digital logic simulation
