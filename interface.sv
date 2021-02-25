interface gi (input reg clk, input reg reset);
  reg [31 :0] addr,data_in ; //addr and data bus 
  reg rw ;                   //read write bit
  reg [31 :0] data_out ;
  reg [1:0] ss         ;//serial stream in data bus
  
  modport DUT (input clk, input reset, input addr , input data_in, input rw , output ss, output data_out); //talking to DUT through modport by giving direction
  
endinterface
  
  
