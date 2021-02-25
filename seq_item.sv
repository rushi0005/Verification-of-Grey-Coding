typedef enum {Dreset,
			  Dwrite,
				Dread} Dcmd ;

class my_seq_item extends uvm_sequence_item ;
  `uvm_object_utils(my_seq_item)
  
  
  
  				 Dcmd cmd ;
       logic [31 :0] addr ;
  rand logic [31 :0] data ;
  
  
  function new (string name = "my_seq_item");
    super.new(name);
  endfunction
  
  
  
  
  
  
  
endclass : my_seq_item
