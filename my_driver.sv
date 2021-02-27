class my_driver extends uvm_driver #(my_seq_item) ;
  `uvm_component_utils(my_driver)
  my_seq_item res ;
  virtual gi xx   ;
  function new (string name = "my_driver", uvm_component parent );
    super.new(name,parent);
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    //res = my_seq_item :: type_id :: create("res",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (uvm_config_db#(virtual gi)::get(null,"dp","intf",xx));
    else begin
      `uvm_fatal("config", "DIdnot get intf");
    end
    endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin 
     res = new() ;
     seq_item_port.get_next_item(res);
      case(res.cmd)
        Dreset : do_reset(res);
        Dwrite : do_write(res);
        Dread : do_read(res);
      endcase
     //drive(res);
     seq_item_port.item_done();
   end
  endtask
  task do_reset (my_seq_item m );
    xx.reset = 1 ;
    xx.addr = 0 ;
    xx.datain = 0 ;
    xx.rw = 0 ;
    @(posedge (xx.clk)) #1
    xx.reset = 0 ;
  endtask
  
  task do_write (my_seq_item m);
    xx.addr = m.addr ;
    xx.datain = m.data ;
    xx.rw = 1 ;
    @(posedge (xx.clk))
    xx.rw = 0 ;
    xx.addr = 32'h0bad ;
  endtask
  
  
  task do_read (my_seq_item m);
    xx.addr = m.addr ;
    xx.datain = m.data ;
    xx.rw = 0 ;
    @(posedge (xx.clk))
    xx.rw = 0 ;
    xx.addr = 32'h0bad ;
  endtask
endclass
