// grey scale serial thing
/*
Reg size Function
0   32   Divider (silly big)
4   4    Number of bits 0-16 (coded n-1)
8   16   16 bits of data to be transmitted (LSB sent first)
12  2    Read only status { xmit_busy, xmit_loaded } (May take 2 clocks to change)

All registers read back


*/


module grey_scale(gi.DUT m);

reg [31:0] cdiv,cdiv_d;
reg [3:0] nbits,nbits_d;
reg [3:0] bcnt,bcnt_d;
reg [15:0] xmit_data,xmit_data_d;

reg [15:0] xd,xd_d;	// internal transmit data
reg [31:0] dcnt,dcnt_d;	// counter for divisions
reg [1:0] gs,gs_d;	// internal grey scale counter
reg dataload,dataload_d;		// loading the data this cycle...
reg xmit_busy,xmit_busy_d,xmit_loaded,xmit_loaded_d; // transmitter status
logic div_event;
typedef enum reg[2:0] {
	Sreset,
	Swaiting,
	Ssetup,
	Stransmit,
	Sdone
} State;

State cur,nxt;


function reg[1:0] next_grey(input reg dir,input reg [1:0] cp);
	if(dir==1) begin // forward
		case(cp)
			0: return 1;
			1: return 3;
			2: return 0;
			3: return 2;
		endcase
	end else begin
		case(cp)
			0: return 2;
			1: return 0;
			3: return 1;
			2: return 3;
		endcase
	end
	return 0;
endfunction : next_grey

always @(*) begin
	cdiv_d=cdiv;
	nbits_d=nbits;
	xmit_data_d=xmit_data;
	xd_d=xd;
	dcnt_d=dcnt;
	gs_d=gs;
	dataload=0;
	m.dataout=0;
	xmit_busy_d=xmit_busy;
	xmit_loaded_d=xmit_loaded;
	dataload_d=dataload;
	nxt=cur;
// the divider
	dcnt_d=dcnt+1;
	if(dcnt_d>=cdiv) begin
		dcnt_d=0;
		div_event=1;
	end else begin
		div_event=0;
	end
// write the registers
	if(m.rw) begin
		case(m.addr)
			0: cdiv_d=m.datain;
			4: nbits_d=m.datain;
			8: begin
				xmit_data=m.datain;
				dataload_d=1;
				dcnt_d=0;
			end
		endcase
	end else begin
		case(m.addr)
			0: m.dataout=cdiv;
			4: m.dataout=nbits;
			8: m.dataout=xmit_data;
			12: m.dataout={xmit_busy,xmit_loaded};
		endcase
	end
	
	case(cur)
		Sreset: begin
			nxt=Swaiting;
		end
		Swaiting: begin
			if(dataload) begin
				xmit_busy_d=1;
				xmit_loaded_d=0;
				xd_d=xmit_data;
				bcnt_d=0;
				nxt=Ssetup;
			end
		end
		Ssetup: begin
			nxt=Stransmit;
		end
		Stransmit: begin
			if(div_event) begin
				gs_d=next_grey(xd[0],gs);
				xd_d=xd>>1;
				bcnt_d=bcnt+1;
				if(bcnt==nbits) begin
					nxt=Sdone;
				end
			end
		end
		Sdone: begin
			if(div_event) begin
				xmit_busy_d=0;
				nxt=Swaiting;
			end
		end
	endcase
	m.ss=gs;
end

always @(posedge(m.clk) or posedge(m.reset)) begin
	if(m.reset) begin
		cdiv<= 0;
		nbits<= 0;
		xmit_data<=0;
		xd<=0;
		dcnt<=0;
		gs<= 0;
		xmit_busy<=0;
		xmit_loaded<=0;
		cur<= Sreset;
		dataload<= 0;
	end else begin
		cdiv<= #1 cdiv_d;
		nbits<= #1 nbits_d;
		xmit_data<= #1 xmit_data_d;
		xd<= #1 xd_d;
		dcnt<= #1 dcnt_d;
		gs<= #1 gs_d;
		xmit_busy<= #1 xmit_busy_d;
		xmit_loaded<= #1 xmit_loaded_d;
		cur <= #1 nxt;
		dataload<= #1 dataload_d;
	end
end



endmodule : grey_scale

