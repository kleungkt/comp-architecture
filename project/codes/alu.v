module ALU(OP,A,B,F,ZF,CF,OF,SF,PF);
    parameter SIZE = 64;
    input [3:0] OP;
    input [SIZE-1:0] A;//r1
    input [SIZE-1:0] B;//r2
    output reg [SIZE-1:0] F;//result
    output  ZF, 
            CF, 
            OF, 
            SF, 
            PF; /
    //reg [SIZE:1] F;
    reg C,ZF,CF,OF,SF,PF;
    always@(*)
    begin
        C=0;
        case(OP)
            4'b0000:begin F=A&B; end    //and
            4'b0001:begin F=A|B; end    //or
            4'b0010:begin {C,F}=A+B; end    //add
            4'b0011:begin F=A<<B; end //sll
            4'b0100:begin F=($signed(A)<$signed(B))? 1 : 0; end //slt
            4'b0101:begin F=(A<B)? 1 : 0;end //sltu
            4'b0110:begin {C,F}=A-B; end    //sub
            4'b0111:begin F=A^B; end   //xor
				4'b1000:begin F=A>>B; end   //srl
				4'b1001:begin F=($signed(A))>>>B; end   //sra
				4'b1010:begin F=B; end   //lui
        endcase
        ZF = F==0;
        CF = C;
        OF = A[SIZE-1]^B[SIZE-1]^F[SIZE-1]^C;
        SF = F[SIZE-1];
        PF = ~^F;/
    end     
endmodule
