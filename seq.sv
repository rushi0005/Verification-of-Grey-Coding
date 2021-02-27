class my_seq extends uvm_sequence #(my_seq_item);
  `uvm_object_utils(my_seq)
  
  my_seq_item mx ;
  function new (string name = "my_seq");
    super.new(name);
  endfunction
  
  task body() ;
    mx = my_seq_item :: type_id :: create ("mx");
    repeat(5) Reset(); //one reset is not enough so 5 times
    repeat(10) begin
      mx.randomize();
      WR(0,mx.data);
    end
      
    
  endtask 
  
  task Reset();
   wait_for_grant();
   mx.cmd = Dreset ;
   mx.addr = 32'h0 ;
   mx.data = 32'hdeadbeaf ;
   send_request(mx);
   wait_for_item_done();
    
  endtask
  
  task write ( input reg [31 :0] addr , input [31 :0] datain) ;
  	wait_for_grant ();
    mx.cmd = Dwrite ;
    mx.addr = addr  ;
    mx.data = datain;
    send_request(mx);
    wait_for_item_done();
  endtask
  
  task read ( input reg [31 :0] addr) ;
  	wait_for_grant ();
    mx.cmd = Dread ;
    mx.addr = addr  ;
    mx.data = 0;
    send_request(mx);
    wait_for_item_done();
  endtask
  
  task WR(input reg [31 :0] addr , input [31 :0] datain);
    write(addr,datain);
    read(0);
  endtask
endclass : my_seq
