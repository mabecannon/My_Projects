`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2019 02:58:56 PM
// Design Name: 
// Module Name: parity_bit_serial_transmitter
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


module my_tx(input clock, input tx_start, input [7:0] data_in, output tx, output tx_done, output p);
wire bclk;
wire s, w, ser;
wire reset = ~tx_start; 
wire [2:0] sevencheck;
shift_register regi(clock, reset, tx_start, data_in, w);
FSM_parity_bit parity(clock, reset, w, tx_done, p);

counter count(clock, reset, sevencheck); 

counter_switch swt(clock, sevencheck, s);

MUX muxiboi(s, w, p, ser);

DFF d0(ser, clock, tx);


endmodule

module DFF(input D, input clk, output reg Q);
always@(posedge clk)
begin
    Q<=D;
end
endmodule

module slow_clock(input clk, output reg timing_clk = 0);
    reg [3:0] x = 0;
    always@(posedge clk)
        begin
            if(x==8)
                begin
                timing_clk = ~timing_clk;
                x = 0;
                end
                x = x+1;
        end
endmodule

module counter_switch(input clk, input[2:0] x, output reg s = 0);
always@(posedge clk)
begin
if(x[0] == 1 && x[1] == 1 && x[2] == 1)
    s = 1;
else
s = 0;
end
endmodule

module counter(input clock, input reset, output reg [2:0] count = 0);
always@(posedge clock)
begin
if(count == 7 || reset)
count = 0;
else
count = count + 1;
end
endmodule

module MUX(input s, input w, input parity, output reg serial);
always@*
begin
    serial = w;
    if(s==1)
    serial = parity;
end
endmodule

module FSM_parity_bit(input clock, input reset, input serial, output reg done = 0, output reg p = 0);

localparam p0 = 1'b0, p1 = 1'b1;
reg [2:0] count = 0;
reg [2:0] sum = 0;

reg state_reg = p1;
reg state_next = p1;
reg done_next = 0;

always@(posedge clock)
begin
count = count+1;
sum = sum + serial;
if(reset || done)
begin
    count = 0;
    sum = 0;
    state_reg = p1;
    state_next = p1;
    done_next = 0;
    p = 0;
    done = 0;
end
else
begin
state_reg <= state_next;
done <= done_next;
end
end

always@*
begin
    case(state_reg)
    p0:
    begin
        if(sum%2==0)
        begin
        p <= 1;
        state_next <= p1;
        end
        if(count == 7)
        done_next <= 1;
    end
    p1:
    begin
        if(sum%2 == 1)
        begin
        p <= 0;
        state_next <= p0;
        end
        if(count == 7)
        done_next <= 1;
        
    end
    endcase
    end

endmodule


module shift_register(input clk, input Load, input start, input [7:0] para, output reg w = 0);
   reg [6:0] serial = 0;//the data we feed to output
   reg [6:0] serial_reg = 0;//the data we feed to serial
   reg w_reg = 0;
   reg x = 0;
   always@(posedge clk)
    begin
    if(Load)
    begin
           w_reg <= para[0];  
           serial_reg[0] <= para[1];
           serial_reg[1] <= para[2];
           serial_reg[2] <= para[3];
           serial_reg[3] <= para[4];
           serial_reg[4] <= para[5];
           serial_reg[5] <= para[6];
           serial_reg[6] <= para[7]; 
           x = 0;
    end
    else if(start)
    begin
    
           w <= w_reg;
           serial[0] <= serial_reg[0];
           serial[1] <= serial_reg[1];
           serial[2] <= serial_reg[2];
           serial[3] <= serial_reg[3];
           serial[4] <= serial_reg[4];
           serial[5] <= serial_reg[5];//keep feeding register same message until new one is Loaded 
           serial[6] <= serial_reg[6];   
           
           w_reg <= serial_reg[0];  
           serial_reg[0] <= serial_reg[1];
           serial_reg[1] <= serial_reg[2];
           serial_reg[2] <= serial_reg[3];
           serial_reg[3] <= serial_reg[4];
           serial_reg[4] <= serial_reg[5];
           serial_reg[5] <= serial_reg[6];//keep feeding register same message until new one is Loaded 
           serial[6] <= 0;   
        end
     end
endmodule 