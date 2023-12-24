
module alu #(
    parameter DATA_WIDTH = 32,
    parameter INST_WIDTH = 4
)(
    input                   i_clk,
    input                   i_rst_n,
    input  [DATA_WIDTH-1:0] i_data_a,
    input  [DATA_WIDTH-1:0] i_data_b,
    input  [INST_WIDTH-1:0] i_inst,
    input                   i_valid,
    output [DATA_WIDTH-1:0] o_data,
    output                  o_overflow,
    output                  o_valid
);

reg [31:0] o_data;
reg o_overflow,o_valid;

always @(*)
begin
    if(i_rst_n)
        begin
            o_data<=32'd0;
            o_overflow<=1'b0;
            o_valid<=1'b0;
        end
    else 
        begin
            case(i_inst)
            	0000:
            		begin
				o_data = $signed(i_data_a) + $signed(i_data_b);
				o_valid=1'b1;
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
            		end
            	0001:
            		begin
				o_data = $signed(i_data_a) - $signed(i_data_b);
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
				o_valid=1'b1;
            		end
            	0010:
            		begin
				o_data = $signed(i_data_a) * $signed(i_data_b);
				o_valid=1'b1;
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
            		end
            	0011:
            		begin
            			if($signed(i_data_a) > $signed(i_data_b))
            				begin
            					o_data = $signed(i_data_a);
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            			else
            				begin
            					o_data = $signed(i_data_b);
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            		end
            	0100:
            		begin
            			if($signed(i_data_a) < $signed(i_data_b))
            				begin
            					o_data = $signed(i_data_a);
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            			else
            				begin
            					o_data = $signed(i_data_b);
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            		end
            	0101: //unsigned
            		begin
				o_data = i_data_a + i_data_b;
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
				o_valid=1'b1;
				
            		end
            	0110:
            		begin
				o_data = i_data_a - i_data_b;
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
				o_valid=1'b1;
            		end
            	0111:
            		begin
				o_data = i_data_a * i_data_b;
				if(i_data_a[31])
				    begin
				        if(i_data_b[31])
				            begin
				                o_overflow=1'b1;
				            end
				    end
				o_valid=1'b1;
            		end
            	1000:
            		begin
            			if(i_data_a > i_data_b)
            				begin
            					o_data = i_data_a;
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            			else
            				begin
            					o_data = i_data_b;
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            		end
            	1001:
            		begin
            			if(i_data_a < i_data_b)
            				begin
            					o_data = i_data_a;
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            			else
            				begin
            					o_data = i_data_b;
            					o_overflow=1'b0;
            					o_valid=1'b1;
            				end
            		end
            	1010:
            		begin
            			o_data = i_data_a & i_data_b;
            			o_overflow=1'b0;
            			o_valid=1'b1;
            		end
            	1011:
            		begin
            			o_data = i_data_a | i_data_b;
            			o_overflow=1'b0;
            			o_valid=1'b1;
            		end
            	1100:
            		begin
            			o_data = i_data_a ^ i_data_b;
            			o_overflow=1'b0;
            			o_valid=1'b1;
            		end
            	1101:
            		begin
            			o_data = ~(i_data_a) ;
            			o_overflow=1'b0;
            			o_valid=1'b1;
            		end
            	1110:
            		begin
            			o_data[31:0] = {i_data_a[0],i_data_a[1],i_data_a[2],i_data_a[3],i_data_a[4],i_data_a[5],i_data_a[6],i_data_a[7],i_data_a[8],i_data_a[9],i_data_a[10],i_data_a[11],i_data_a[12],i_data_a[13],i_data_a[14],i_data_a[15],i_data_a[16],i_data_a[17],i_data_a[18],i_data_a[19],i_data_a[20],i_data_a[21],i_data_a[22],i_data_a[23],i_data_a[24],i_data_a[25],i_data_a[26],i_data_a[27],i_data_a[28],i_data_a[29],i_data_a[30],i_data_a[31],i_data_a[32]};
            			o_overflow=1'b0;
            			o_valid=1'b1;
            		end
            	   	
            endcase
        end
end
endmodule
