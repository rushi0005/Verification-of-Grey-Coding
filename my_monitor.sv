class my_monitor extends uvm_monitor ;
  `uvm_component_utils(my_monitor) 
  uvm_analysis_port#(mimsg) pdat ;
  mimsg m ;
  
  virtual gi dut_intf ;
  
  function new (string name = "my_monitor", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    pdat = new("mimsg", this);
  endfunction
  
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
     if (uvm_config_db#(virtual gi)::get(null,"dp","intf",dut_intf));
    else begin
      `uvm_fatal("config", "DIdnot get intf");
    end
    endfunction
  
  task run_phase(uvm_phase phase);  //getting in terface signal 
    forever @(posedge dut_intf.clk)begin
      if(!dut_intf.reset && dut_intf.addr <= 12) begin
        m = new ();
        m.addr = dut_intf.addr ;
        m.rw = dut_intf.rw ;
        if(dut_intf.rw == 0) begin
          m.data=dut_intf.datain ;
        end
        else begin
          m.data=dut_intf.dataout ;
        end
        pdat.write(m);
      end
    end
  endtask
        
  
endclass
