// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
// sequence sequencer Driver monitor scoreboard Testbench top module 
`include "interface.sv"
package ydv ;
 import uvm_pkg :: * ;

		

	`include "my_seq_item.sv"
	`include "mimsg.sv"
	`include "my_seq.sv"
	`include "my_scoreboard.sv"
	`include "my_sequencer.sv"
    `include "my_driver.sv"
	`include "my_monitor.sv"
	`include "my_agent.sv"
    `include "my_test.sv" 



endpackage


//import uvm_pkg :: * ;
`timescale 1ns/10ps
module top ();
  reg clk ;
  import uvm_pkg :: * ;
  
  initial begin
    clk = 0 ;
    
    forever begin 
      #5 clk = ~clk ;
    end
  end
  
  
  gi intf (clk);
  grey_scale go (intf.DUT);
  
  
  initial begin 
    $display("I am inside top module");
  end
  initial begin 
  end
  
  initial begin
  
    uvm_config_db#(virtual gi)::set(null,"dp","intf", intf);
    run_test("my_test");
  end
  initial begin
    $dumpfile("my_file.vcd");
    $dumpvars(0,top);
  end
  
endmodule

`include "design1.sv"
 
