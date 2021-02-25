class my_seq extends uvm_sequence #(my_seq_item);
  `uvm_object_utils(my_seq)
  
  my_seq_item mx ;
  function new (string name = "my_seq");
    super.new(name);
  endfunction
  
  virtual task body() ;
    mx = my_seq_item :: type_id :: create ("mx");
   wait_for_grant();
   mx.cmd = Dreset ;
   mx.addr = 32'h0 ;
   mx.data = 32'hdeadbeaf ;
    send_request(mx);
   wait_for_item_done();
    repeat(10) begin
      wait_for_grant ();
      mx.cmd = Dwrite ;
      mx.addr = 32'h4 ;
      mx.randomize with {data < 32'h0000_0030 ;};
      send_request(mx);
      wait_for_item_done();
    end
    
  endtask 
  
  
  
  
endclass : my_seq
