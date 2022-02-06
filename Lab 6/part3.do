# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets

force Clock 0 0ns, 1 1ns -r 2ns
force {Resetn} 1
force {Go} 1
force {Divisor} 1110
force {Dividend} 0001
run 10ns
force {Go} 0

run 100ns

force {Resetn} 1
force {Go} 1
force {Divisor} 0100
force {Dividend} 1011
run 10ns
force {Go} 0

run 100ns


