class my_scoreboard extends uvm_scoreboard ;
  `uvm_component_utils(my_scoreboard);
  uvm_tlm_analysis_fifo#(mimsg) message ;
  mimsg w,r,m ;
  
  function new (string name = "my_scoreboard", uvm_component parent);
    super.new(name ,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    message = new("mi_imp",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      message.get(m);
     // `uvm_info("debug",$sformatf("a %0h d %0h rw %0h ", m.addr,m.data, m.rw), UVM_MEDIUM);
      if(m.addr != 0) continue ;
      if(m.rw) begin
        w = m ;
      end
      else begin
        if(w.data != m.data)begin
          `uvm_fatal("dataread", "DATA written is not read")
        end
      end
        
    end
  endtask
  
endclass
  
  
