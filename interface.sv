interface gi (input reg clk);
  reg [31 :0] addr,datain ; //addr and data bus 
  reg rw ;                   //read write bit
  reg [31 :0] dataout ;
  reg [1:0] ss         ;//serial stream in data bus
  reg reset ;
  modport DUT (input clk, input reset, input addr , input datain, input rw , output ss, output dataout); //talking to DUT through modport by giving direction
  
endinterface
  
  
  
  
