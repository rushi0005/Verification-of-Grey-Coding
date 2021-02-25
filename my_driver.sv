class my_driver extends uvm_driver #(my_seq_item) ;
  `uvm_component_utils(my_driver)
  my_seq_item res ;
  
  function new (string name = "my_driver", uvm_component parent );
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    //res = my_seq_item :: type_id :: create("res",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
     res = new() ;
     seq_item_port.get_next_item(res);
     drive(res);
     seq_item_port.item_done();
   end
  endtask
  task drive (my_seq_item res );
    $display("Value of data %0h", res.data);
  endtask
endclass
