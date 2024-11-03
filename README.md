# RISCV_RTL-
In-order RISCV core. Out-of-Order design in progress.

# How to Run
iverilog -g2012 -o dsn core.sv test.sv decode.sv execute.sv alu.sv RISCV_Lib.sv regfile.sv fetch.sv
