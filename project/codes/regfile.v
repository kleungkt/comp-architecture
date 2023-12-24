module RegFile(	Clk,
						rst_n,
						Write_en,
						R_Addr_A,
						R_Addr_B,
						W_Addr,
						W_Data,
						R_Data_A,
						R_Data_B
						);
						
    parameter ADDR = 5;
    parameter NUMB = 1<<ADDR;
    parameter SIZE = 64;
    
    input Clk;
    input rst_n;
    input Write_en;
	 wire wen;
    input [ADDR-1:0]R_Addr_A;
    input [ADDR-1:0]R_Addr_B;
    input [4:0]W_Addr;
    input [SIZE-1:0]W_Data;
    
    output [SIZE-1:0]R_Data_A;
    output [SIZE-1:0]R_Data_B;
	 
    assign wen= W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4];
    reg [SIZE-1:0]REG_Files[0:NUMB-1];
    integer i;
    
    initial/
        for(i=0;i<NUMB;i=i+1) REG_Files[i]<=0;
    always@(negedge Clk or negedge rst_n)
    begin
        if(!rst_n) 
			begin
           for(i=0;i<NUMB;i=i+1) REG_Files[i]<=0;
			end
        else
				//if(W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4])
					if(Write_en&(W_Addr[0]|W_Addr[1]|W_Addr[2]|W_Addr[3]|W_Addr[4])) 
							REG_Files[W_Addr]<=W_Data;
    end
    
  
    assign R_Data_A=REG_Files[R_Addr_A];
    assign R_Data_B=REG_Files[R_Addr_B];

endmodule
