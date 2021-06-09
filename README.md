# Modulo_counter
Modulo counter implemented with verilog on FPGA.

Assumptions:

* Counter modulo N = 9 with asynchronous reset, works with positive integers.
* Modes:
  * Load 4 bit number (also Mod 9 operation). If 11 is loaded, should save 2 in the counter register.
  * Stop Counting
  * Count +1.
  * Count -2.
