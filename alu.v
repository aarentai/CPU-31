`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/14 18:49:19
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input signed [31:0] a,
    input signed [31:0] b,
    input [3:0] aluc,
    output reg [31:0] r,
    output reg zero,
    output reg carry,
    output reg negative,
    output reg overflow
    );
    
    reg [32:0] re;
    reg [31:0] a1;
    reg [31:0] b1;
    
   always@(*)
   begin
        if(aluc[3:2]==2'b00)
        begin
         if(aluc[1:0]==2'b00)
           begin
               re<={1'b0,a}+{1'b0,b};
               r<=re[31:0];
               carry<=re[32];
           end
           
           if(aluc[1:0]==2'b01)
           begin
               re<={1'b0,a}-{1'b0,b};
               r<=re[31:0];
               carry<=re[32];
           end
           
           if(aluc[1:0]==2'b10)
           begin
               r<=a+b;
               
               if(a[31]==1&b[31]==1)
               begin
                   if(r[31]==0)
                       overflow<=1;
                   else
                       overflow<=0;
               end
               
               if(a[31]==0&b[31]==0)
               begin
                   if(r[31]==1)
                       overflow<=1;
                   else
                       overflow<=0;
               end
           end
           
           if(aluc[1:0]==2'b11)
           begin
               r<=a-b;
               
               if(a[31]==0&b[31]==1)
               begin
                   if(r[31]==1)
                       overflow<=1;
                   else
                       overflow<=0;
               end
               
               else if(a[31]==1&b[31]==0)
               begin
                   if(r[31]==0)
                       overflow<=1;
                   else
                       overflow<=0;
               end
               else
                overflow<=0;
           end
           
          
           zero=r[31:0]==0?1:0;
           negative=r[31]==1?1:0;
        end
        
        if(aluc[3:2]==2'b01)
        begin
            if(aluc[1:0]==2'b00)
                r <= a & b;
            else if(aluc[1:0]==2'b01)
                r <= a | b;
            else if(aluc[1:0]==2'b10)
                r <= a ^ b;
            else
                r <= ~( a | b);
            
            zero<=r==0?1:0;
            negative<=r[31]==1?1:0;
        end
        
        if(aluc[3:1]==3'b100)
        begin
            r<={b[15:0],16'b0};
            zero<=r==0?1:0;
            negative<=r[31]==1?1:0;
        end
        
        if(aluc[3:1]==3'b101)
        begin
            if(aluc[0]==0)
            begin
                a1<=a;
                b1<=b;
                negative<=0;
                
                if({1'b0,a1}<{1'b0,b1})
                begin
                    r<=1;
                    carry<=1;
                end
                else
                begin
                    r<=0;
                    carry<=0;
                end
            end
            
            else
            begin
                if(a<b)
                begin
                    r <= 1;
                    negative <= 1;
                end
                else
                begin
                    r <= 0;
                    negative <= 0;
                end
            end
            /*
            begin
                if(a[31]==1&b[31]==0)
                begin
                    r<=1;
                    negative<=1;
                end
                else if(a[31]==0&b[31]==1)
                begin
                    r<=0;
                    negative<=0;
                end
                else
                begin
                    if(a<b)
                    begin
                        r<=1;
                        negative<=1;
                    end
                    else
                    begin
                        r<=0;
                        negative<=0;
                    end
                end
            end
            */
            if(a==b)
                zero<=1;
            else
                zero<=0;
        end
        
        if(aluc[3:2]==2'b11)
        begin
            if(aluc[1:0]==2'b00)
               begin
                   r <= b >>> a;
                   carry = b[a-1];
               end
               if(aluc[1:0]==2'b01)
               begin
                   r <= b >> a;
                   carry = b[a-1];
               end
               if(aluc[1]==1)
               begin
                   r <= b << a;
                   carry = b[32-a];
               end
                   
               carry=a==0?0:carry;    
               zero<=r==0?1:0;
               negative<=r[31]==1?1:0;
        end
    end                    
                       

endmodule
