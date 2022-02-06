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

force ClockIn 0 0ns, 1 1ns -r 2ns

run 2ns
force Resetn 1
run 2ns	
force Resetn 0
run 2ns
force Resetn 1
run 2ns

force Letter 2#000
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#001
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#010
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#011
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#100
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#101
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#110
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#111
run 2ns
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#111
run 2ns
force Resetn 0
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#111
run 2ns
force Resetn 1
force Start 1
run 2ns
force Start 0
run 10000ns

force Letter 2#110
run 2ns
force Start 0
run 2ns
force Start 0
run 10000ns