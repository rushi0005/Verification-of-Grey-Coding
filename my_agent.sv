class my_agent extends uvm_agent ;
  `uvm_component_utils(my_agent)
  my_sequencer sequencer1 ;
   my_driver driver1 ;
  function new (string name = "my_agent" , uvm_component parent);
    super.new(name , parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    sequencer1 = my_sequencer :: type_id :: create("sequencer1", this);
    
    driver1    = my_driver    :: type_id :: create ("driver1",this);
  endfunction 
  
  virtual task run_phase (uvm_phase phase);
    super.run_phase(phase);
  endtask
  
  function void connect_phase (uvm_phase phase);
  super.connect_phase (phase);
  driver1.seq_item_port.connect(sequencer1.seq_item_export);  
 endfunction
  
endclass
