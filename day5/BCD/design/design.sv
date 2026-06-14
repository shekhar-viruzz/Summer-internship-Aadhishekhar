//bcd
module Bcd_adder(input [3:0]a,input [3:0]b, input cin,output [3:0]sum, output cout

    );
    wire [8:1]s;
    wire [4:1]w;
    wire k;
    
    Ripple_carry_adder RC1(a[3:0],b[3:0],cin,s[4:1],s[5]);
    and(s[6],s[4],s[3]);
    and(s[7],s[4],s[2]);
    or(s[8],s[5],s[6],s[7]);
    assign w[1]=1'b0;
    assign w[2]=s[8];
    assign w[3]=s[8];
    assign w[4]=1'b0;
    Ripple_carry_adder RC2(s[4:1],w[4:1],1'b0,sum[3:0],k);
     assign cout=s[8];
endmodule
//ripple carry
module Ripple_carry_adder(input [3:0]a_r,
input[3:0]b_r,input cin_r ,output [3:0]s_r,output cout_r
    );
    wire w1,w2,w3;
    fulladder FA1(a_r[0],b_r[0],cin_r,s_r[0],w1);
    fulladder FA2(a_r[1],b_r[1],w1,s_r[1],w2);
    fulladder FA3(a_r[2],b_r[2],w2,s_r[2],w3);
    fulladder FA4(a_r[3],b_r[3],w3,s_r[3],cout_r);
endmodule
//full adder
module fulladder(input a,b,cin, output sum,carry

    );
    wire w1,w2,w3;
    xor(w1,a,b);
    xor(sum,cin,w1);
    and(w2,a,b);
    and(w3,w1,cin);
    or(carry,w2,w3);
endmodule

