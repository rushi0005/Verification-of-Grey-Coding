// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
// sequence sequencer Driver Testbench top module 
`include "interface.sv"
package ydv ;
 import uvm_pkg :: * ;

		

	`include "my_seq_item.sv"
	`include "my_seq.sv"
	
	`include "my_sequencer.sv"
    `include "my_driver.sv"
	`include "my_agent.sv"
    `include "my_test.sv" 



endpackage


//import uvm_pkg :: * ;
`timescale 1ns/10ps
module top ();
  reg clk, reset ;
  import uvm_pkg :: * ;
  gi intf (clk,reset);
  grey_scale go (intf.DUT);
  initial begin 
    $display("I am inside top module");
  end
  initial begin 
  end
  
  initial begin
    run_test("my_test");
  end
  
  
endmodule

`include "design1.sv"
