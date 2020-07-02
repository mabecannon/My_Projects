`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2019 01:43:29 PM
// Design Name: 
// Module Name: Controller
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


module Controller(input Clock, input SW, input[3:0] num0, input[3:0] num1, input[3:0] num2, input[3:0] num3,  output [7:0] CA, output [7:0] AN, output audioOut, output aud_sd);
wire [9:0] decoded, secondControlOnes, secondControlTens, minuteControlOnes, minuteControlTens,secondLoadOnes, secondLoadTens, minuteLoadOnes, minuteLoadTens;
wire out1, reset, out400, resetHour, ALARM, en;
wire[2:0] Z;
wire[3:0] select;
wire[5:0] Q, minutes;
Slow_Clock clocks(Clock, out1, out400);//generate clocks
Three_Bit_Counter counter(out400, Z);//Selects anode and the cathode to display in Z
Six_Bit_Counter count(0, SW, reset, out1, Q);
Decoder dec(Z, AN);
Minute_And_Second_Two_Seven_Seg_Display_Decoder seconds(Q, secondControlOnes, secondControlTens, reset);
Six_Bit_Counter countMin(0, SW, resetHour, reset, minutes);
Minute_And_Second_Two_Seven_Seg_Display_Decoder minute_Counter(minutes, minuteControlOnes, minuteControlTens, resetHour);  
Alarm_Control alarm(num0, num1, num2, num3, secondLoadOnes, secondLoadTens, minuteLoadOnes, minuteLoadTens);
Alarm_Detect detector(secondControlOnes, secondControlTens, minuteControlOnes, minuteControlTens, secondLoadOnes, secondLoadTens, minuteLoadOnes, minuteLoadTens, ALARM);
EN enable(Q, ALARM, en); 
SongPlayer music(Clock, SW, en, audioOut, aud_sd);
MUX mux(secondControlOnes, secondControlTens, minuteControlOnes, minuteControlTens, secondLoadOnes, secondLoadTens, minuteLoadOnes, minuteLoadTens, Z, decoded);
SevenSeg sevenseg(decoded, CA);
endmodule

module Three_Bit_Counter(input my_clock, output reg [2:0] Z = 0);
always@(posedge my_clock)
begin
Z = Z+1;
if(Z==8)
Z = 0; 
end
endmodule

module Six_Bit_Counter(input[5:0] Load, input E, input Resetn, input Clock, output reg [5:0]Q = 0);
	always @(posedge E, posedge Resetn, posedge Clock)
	    if(E == 1)
	    Q <= Load;
	 	else if(Resetn)
		Q <= 0;
		else
		begin
		Q <= Q+1;
		end
endmodule

module Slow_Clock(input clk, output reg outsignal1 = 1, output reg outsignal400 = 1);
reg[26:0] counter1=0;//Will count up to 100 MHz
reg[26:0] counter400=0 ;
always@(posedge clk)//half the clock signal
begin
	  counter1 = counter1 +1;
	  counter400 = counter400 +1;
	  if (counter1 == 50_000_000) //assign outsignal = [(clk/counter)/2] Hz = [(100_000_000/50_000_00)/2] Hz = 2/2 = 1 Hz 
		begin
			outsignal1=~outsignal1;
			counter1 =0;
		end
		 if (counter400 == 125_000)  
		begin
			outsignal400 =~outsignal400;
			counter400 =0;
		end
  end
endmodule

module MUX(input[9:0] A, input[9:0] B, input[9:0] C, input[9:0] D, input[9:0] E, input[9:0] F, input[9:0] G, input[9:0] H, input [2:0] select, output reg [9:0] y); 
always@* 
begin
if(select == 3'b000)
y = A;
else if (select == 3'b001)
y = B;
else if(select == 3'b010) 
y = C;
else if(select == 3'b011)
y = D;
else if (select == 3'b100)
y = E;
else if(select == 3'b101) 
y = F;
else if(select == 3'b110)
y = G;
else if(select == 3'b111)
y = H; 
end
endmodule

module Alarm_Control(input [3:0] num0, input [3:0] num1, input [3:0] num2,input [3:0] num3, output reg [9:0] Sones, output reg [9:0] Stens, output reg [9:0] Mones, output reg [9:0] Mtens);
always @*
begin
Sones = 0;
Stens = 0;
Mones = 0;
Mtens = 0;
Sones[num0] = 1;
Stens[num1] = 1;
Mones[num2] = 1;
Mtens[num3] = 1;
end
endmodule

module Alarm_Detect(input[9:0] A, input[9:0] B, input[9:0] C, input[9:0] D, input[9:0] E, input[9:0] F, input[9:0] G, input[9:0] H, output reg ALARM = 0);
always @*
begin
if(A == E && B == F && C == G && D == H && A!= 1 && B != 1 && C != 1 && D != 1)
begin
ALARM = 1;
end
else 
ALARM = 0;
end
endmodule

module EN(input clock, input alarm, output reg en = 0);
reg k = 0;
always @(clock, alarm)
begin
k = k+1;
if(alarm == 1)
begin
en = 1;
k = 0;
end
if(k == 10)
begin
en = 0;
k = 0;
end
end
endmodule

module Minute_And_Second_Two_Seven_Seg_Display_Decoder(input [5:0] count, output reg [9:0] ones = 0, output reg [9:0] tens = 0, output reg reset);
integer x = 0; 
always @(count)
begin
ones = 0;
tens = 0;
ones[x] = 1;
tens[(count-x)/10] = 1;
if(reset == 1)
begin 
reset = 0;
end
if(count%60 == 0 && count !=0)
reset = 1;
x = count%10;
end
endmodule

module Decoder(input[2:0] x, output reg [7:0] y);
always@(x)
begin 
y = 8'b11111111;
y[x] = 0;
end
endmodule

module SevenSeg(input [9:0] control, output reg [7:0] C);
always @(control)
begin
case(control)
10'b0000000001: C = 8'b10000001;//0
10'b0000000010: C = 8'b11001111;//1
10'b0000000100: C = 8'b10010010;//2
10'b0000001000: C = 8'b10000110;//3
10'b0000010000: C = 8'b11001100;//4
10'b0000100000: C = 8'b10100100;//5
10'b0001000000: C = 8'b10100000;//6
10'b0010000000: C = 8'b10001111;//7
10'b0100000000: C = 8'b10000000;//8
10'b1000000000: C = 8'b10001100;//9
endcase
end
endmodule

module MusicSheet( input [9:0] number, 
	output reg [19:0] note,//max 32 different musical notes
	output reg [6:0] duration);
parameter   QUARTER = 7'b0010000;//2.5 Hz
parameter	HALF = 7'b0100000;
parameter	WHOLE = 2* HALF;
parameter	ETH =  QUARTER/2;
parameter	S =  ETH/2;
parameter   REST = QUARTER/16;
parameter  R = 1, A0=27.5, A0s=29.1352, B0=30.8677, C0=32.7032, C0s=34.6478, D0=36.7081, D0s=38.8909, E0=41.2034, F0=43.6535, F0s=46.2493, G0=48.9994, G0s=51.9131, A1=55, A1s=58.2705, B1=61.7354, C1=65.4064, C1s=69.2957, D1=73.4162, D1s=77.7817, E1=82.4069, F1=87.3071, F1s=92.4986, G1=97.9989, G1s=103.826, A2=110, A2s=116.541, B2=123.471, C2=130.813, C2s=138.591, D2=146.832, D2s=155.563, E2=164.814, F2=174.614, F2s=184.997, G2=195.998, G2s=207.652, A3=220, A3s=233.082, B3=246.942, C3=261.626, C3s=277.183, D3=293.665, D3s=311.127, E3=329.628, F3=349.228, F3s=369.994, G3=391.995, G3s=415.305, A4=440, A4s=466.164, B4=493.883, C4=523.251, C4s=554.365, D4=587.33, D4s=622.254, E4=659.255, F4=698.456, F4s=739.989, G4=783.991, G4s=830.609, A5=880;  
 
always @ (number) begin
case(number) //Sandstorm
0: begin note = R; duration = REST; end
1: begin note = B3; duration = S;  end
2: begin note = R; duration = REST; end
3: begin note = B3; duration = S;  end
4: begin note = R; duration = REST; end
5: begin note = B3; duration = S;  end
6: begin note = R; duration = REST; end
7: begin note = B3; duration = S;  end
8: begin note = R; duration = REST; end
9: begin note = B3; duration = ETH+S; end

10: begin note = R; duration = REST; end
11: begin note = B3; duration = S;  end
12: begin note = R; duration = REST; end
13: begin note = B3; duration = S;  end
14: begin note = R; duration = REST; end
15: begin note = B3; duration = S;  end
16: begin note = R; duration = REST; end
17: begin note = B3; duration = S;  end
18: begin note = R; duration = REST; end
19: begin note = B3; duration = S;  end
20: begin note = R; duration = REST; end
21: begin note = B3; duration = S;  end
22: begin note = R; duration = REST; end
23: begin note = B3; duration = ETH+S; end

24: begin note = R; duration = REST; end
25: begin note = E3; duration = S;  end
26: begin note = R; duration = REST; end
27: begin note = E3; duration = S;  end
28: begin note = R; duration = REST; end
29: begin note = E3; duration = S;  end
30: begin note = R; duration = REST; end
31: begin note = E3; duration = S;  end
32: begin note = R; duration = REST; end
33: begin note = E3; duration = S;  end
34: begin note = R; duration = REST; end
35: begin note = E3; duration = S;  end
36: begin note = R; duration = REST; end
37: begin note = E3; duration = ETH+S; end

38: begin note = R; duration = REST; end
39: begin note = D3; duration = S;  end
40: begin note = R; duration = REST; end
41: begin note = D3; duration = S;  end
42: begin note = R; duration = REST; end
43: begin note = D3; duration = S;  end
44: begin note = R; duration = REST; end
45: begin note = D3; duration = S;  end
46: begin note = R; duration = REST; end
47: begin note = D3; duration = S;  end
48: begin note = R; duration = REST; end
49: begin note = D3; duration = S;  end
50: begin note = R; duration = REST; end
51: begin note = D3; duration = ETH+S; end

52: begin note = R; duration = REST; end
53: begin note = A3; duration = S;  end
54: begin note = R; duration = REST; end
55: begin note = A3; duration = S;  end
56: begin note = R; duration = REST; end
57: begin note = B3; duration = S;  end
58: begin note = R; duration = REST; end
59: begin note = B3; duration = S;  end
60: begin note = R; duration = REST; end
61: begin note = B3; duration = S;  end
62: begin note = R; duration = REST; end
63: begin note = B3; duration = S;  end
64: begin note = R; duration = REST; end
65: begin note = B3; duration = ETH+S; end

66: begin note = R; duration = REST; end
67: begin note = E3; duration = S;  end
68: begin note = R; duration = REST; end
69: begin note = E3; duration = S;  end
70: begin note = R; duration = REST; end
71: begin note = B3; duration = S;  end
72: begin note = R; duration = REST; end
73: begin note = B3; duration = S;  end
74: begin note = R; duration = REST; end
75: begin note = B3; duration = S;  end
76: begin note = R; duration = REST; end
77: begin note = B3; duration = S;  end
78: begin note = R; duration = REST; end
79: begin note = B3; duration = ETH+S; end

80: begin note = R; duration = REST; end
81: begin note = B3; duration = S;  end
82: begin note = R; duration = REST; end
83: begin note = B3; duration = S;  end
84: begin note = R; duration = REST; end
85: begin note = B3; duration = S;  end
86: begin note = R; duration = REST; end
87: begin note = B3; duration = S;  end
88: begin note = R; duration = REST; end
89: begin note = B3; duration = S;  end
90: begin note = R; duration = REST; end
91: begin note = B3; duration = S;  end
92: begin note = R; duration = REST; end
93: begin note = B3; duration = ETH+S; end

94: begin note = R; duration = REST; end
95: begin note = E3; duration = S;  end
96: begin note = R; duration = REST; end
97: begin note = E3; duration = S;  end
98: begin note = R; duration = REST; end
default: 	begin note = C4; duration = QUARTER; 	end
endcase
end
endmodule

module SongPlayer( input clock, input reset, input playSound, output reg audioOut, output wire aud_sd);
reg [19:0] counter, counter1 = 0;
reg [31:0] time1 = 0, noteTime = 0;
reg [9:0] msec = 0, number = 0;	//millisecond counter, and sequence number of musical note.
wire [6:0] note, duration;
wire [19:0] notePeriod;
parameter clockFrequency = 50_000_000;
parameter BPMadjuster = 2_250_000;
parameter length = 98;
assign aud_sd = 1'b1; 
MusicSheet 	mysong(number, notePeriod, duration	);
always @ (posedge clock) 
  begin
	if(reset || ~playSound) 
 		begin 
          counter <=0;  
          time1<=0;  
          number <=0;  
          audioOut <=1;	
     	end
else 
begin
		counter <= counter + 1; 
time1<= time1+1;
		if( counter >= clockFrequency/(2*notePeriod)) 
   begin
			counter <=0;  
			audioOut <= ~audioOut ; 
   end	//toggle audio output 	
		if( time1 > noteTime) 
begin	
				time1 <=0;  
number <= number + 1; 
end  //play next note
 if(number == length) number <=1; // Make the number reset at the end of the song
	end
  end	
         
  always @(duration) noteTime = (duration * BPMadjuster); 
       //number of   FPGA clock periods in one note.
endmodule