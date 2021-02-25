module grey_scale(gi.DUT m);// m is name given modport DUT of interface
  
  
  
  function reg [1:0] nxt_grey (input reg dir, input reg [1:0] cp);
    if(dir == 1 ) begin //forward
      case (cp)
        0 : return 1 ;
        1:  return 3 ;
        2 : return 0 ;
        3 : return 2 ;
      endcase
    end
    return 0 ;
  endfunction
    endmodule
