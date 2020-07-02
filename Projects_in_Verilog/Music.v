`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 03:09:13 PM
// Design Name: 
// Module Name: Music
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

module MusicSheet( input [6:0] number, 
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

module edge_detect_mealy (input wire clk, reset, level, output reg tick);
     localparam zero=1'b0, one=1'b1;
     reg state_reg, state_next;
     always @(posedge clk, posedge reset)
           if (reset)
	state_reg<=zero;
           else
	state_reg<=state_next;
       always@*
            begin
    	state_next=state_reg;
	tick=1'b0;
	case (state_reg)
	   zero:
	        if (level)
	          begin
		tick=1'b1;//this change is immediate
		state_next=one;
	           end
	   one: 
	       if (~level)
		state_next=zero;
	  default: 	 
		state_next=zero;
                         endcase
            end
endmodule

module LED_State_Decoder(input [6:0] state_num, output reg [7:0] left, output reg [7:0] right);
localparam [7:0] s0 = 8'b00000000, s1 = 8'b00000001, s2 = 8'b00000010, s3 = 8'b00000100, s4 = 8'b00001000, s5 = 8'b00010000, s6 = 8'b00100000, s7 = 8'b01000000, s8 = 8'b10000000, s9 = 8'b01010101, s10 = 8'b10101010, s11 = 8'b11111111; 
always @(state_num)
begin
case(state_num)
0: begin left = s0; right = s0; end
1: begin left = s1; right = s8; end
2:begin left = s0; right = s0; end
3: begin left = s2; right = s7; end
4:begin left = s0; right = s0; end
5: begin left = s3; right = s6; end
6:begin left = s0; right = s0; end
7: begin left = s4; right = s5; end
8:begin left = s0; right = s0; end
9: begin left = s11; right = s11; end

10:begin left = s0; right = s0; end
11: begin left = s4; right = s5; end
12:begin left = s0; right = s0; end
13: begin left = s5; right = s4; end
14:begin left = s0; right = s0; end
15: begin left = s6; right = s3; end
16:begin left = s0; right = s0; end
17: begin left = s7; right = s2; end
18:begin left = s0; right = s0; end
19: begin left = s8; right = s1; end
20:begin left = s0; right = s0; end
21: begin left = s9; right = s9; end
22:begin left = s0; right = s0; end
23: begin left = s11; right = s11; end

24:begin left = s0; right = s0; end
25: begin left = s9; right = s9; end
26:begin left = s0; right = s0; end
27: begin left = s9; right = s10; end
28:begin left = s0; right = s0; end
29: begin left = s10; right = s10; end
30:begin left = s0; right = s0; end
31: begin left = s10; right = s9; end
32:begin left = s0; right = s0; end
33: begin left = s9; right = s9; end
34:begin left = s0; right = s0; end
35: begin left = s9; right = s10; end
36:begin left = s0; right = s0; end
37: begin left = s11; right = s11; end

38:begin left = s0; right = s0; end
39: begin left = s10; right = s10; end
40:begin left = s0; right = s0; end
41: begin left = s9; right = s10; end
42:begin left = s0; right = s0; end
43: begin left = s9; right = s9; end
44:begin left = s0; right = s0; end
45: begin left = s10; right = s9; end
46:begin left = s0; right = s0; end
47: begin left = s10; right = s10; end
48:begin left = s0; right = s0; end
49: begin left = s9; right = s10; end
50:begin left = s0; right = s0; end
51: begin left = s11; right = s11; end

52:begin left = s0; right = s0; end
53: begin left = s1; right = s1; end
54:begin left = s0; right = s0; end
55: begin left = s1|s2; right = s1|s2; end
56:begin left = s0; right = s0; end
57: begin left = s1|s2|s3; right = s1|s2|s3; end
58:begin left = s0; right = s0; end
59: begin left = s1|s2|s3|s4; right = s1|s2|s3|s4; end
60:begin left = s0; right = s0; end
61: begin left = s1|s2|s3|s4|s5; right = s1|s2|s3|s4|s5; end
62:begin left = s0; right = s0; end
63: begin left = s1|s2|s3|s4|s5|s6; right = s1|s2|s3|s4|s5|s6; end
64:begin left = s0; right = s0; end
65: begin left = s11; right = s11; end

66:begin left = s0; right = s0; end
67: begin left = s11; right = s0; end
68:begin left = s0; right = s0; end
69: begin left = s0; right = s11; end
70:begin left = s0; right = s0; end
71: begin left = s1; right = s2; end
72:begin left = s0; right = s0; end
73: begin left = s2; right = s3; end
74:begin left = s0; right = s0; end
75: begin left = s3; right = s4; end
76:begin left = s0; right = s0; end
77: begin left = s4; right = s5; end
78:begin left = s0; right = s0; end
79: begin left = s11; right = s11; end

80:begin left = s0; right = s0; end
81: begin left = s5; right = s4; end
82:begin left = s0; right = s0; end
83: begin left = s6; right = s3; end
84:begin left = s0; right = s0; end
85: begin left = s7; right = s2; end
86:begin left = s0; right = s0; end
87: begin left = s8; right = s1; end
88:begin left = s0; right = s0; end
88:begin left = s7; right = s2; end
89:begin left = s0; right = s0; end
90:begin left = s6; right = s3; end
91: begin left = s5; right = s4; end
92:begin left = s0; right = s0; end
93: begin left = s11; right = s11; end

94:begin left = s0; right = s0; end
95: begin left = s11; right = s0; end
96:begin left = s0; right = s0; end
97: begin left = s0; right = s11; end
98:begin left = s0; right = s0; end
default: begin left = s11; right = s11;  end

endcase
end 
endmodule

module SongPlayer( input clock, input EN, output reg audioOut, output wire aud_sd, output R, output G, output B, output [7:0] right, output [7:0] left);
reg [19:0] counter, counter1 = 0;
reg [6:0] number = 1;
reg [31:0] time1 = 0, noteTime = 0;
reg [9:0] msec = 0;	//millisecond counter, and sequence number of musical note.
wire [7:0] R1, B1, G1;
wire [6:0] note, duration;
wire [19:0] notePeriod;
reg playSound = 0, rst = 0;
reg check1 = 1, check2 = 1;
parameter clockFrequency = 50_000_000;
parameter BPMadjuster = 2_250_000;
parameter length = 98;
assign aud_sd = 1'b1; 
LED_State_Decoder dec_two(number, right, left);
RGB_State_Decoder dec(number, R1, G1, B1);
RGB_control ctrl(clock, R1, G1, B1, R, G, B);
MusicSheet 	mysong(number, notePeriod, duration);
always @ (posedge clock)
begin
if(EN && check1)
begin
playSound = ~playSound;
check1 = 0;
end
else if(!EN)
begin
 check1 = 1;
end
	if(~playSound) 
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
       //number of   FPGA clock periods in one note
endmodule

module Eight_Bit_Counter(input[7:0] Load, input E, input Resetn, input Clock, output reg [7:0]Q = 0);
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

module PWM(input clk, input [7:0] X, output reg Xp = 1); 
wire [7:0] Xcount;
reg EN = 0;
Eight_Bit_Counter count(8'b00000000, EN, 0, clk, Xcount); 
always@(posedge clk)
begin
EN = 0;
if(Xcount >= 200)
begin
EN = 1;
end
else if(Xcount >= X)
Xp = 0;
else 
Xp = 1;
end
endmodule

module RGB_control(input clk, input [7:0] Rc, input [7:0] Gc, input [7:0] Bc, output R, output G, output B);
PWM R1(clk, Rc, R);
PWM B1(clk, Bc, B);
PWM G1(clk, Gc, G);
endmodule

module RGB_State_Decoder(input [6:0] state_num, output reg [7:0] R = 0, output reg [7:0] G = 0, output reg [7:0] B = 0);
always @(state_num)
begin
case(state_num)//1-98
0 :begin R = 0; G = 0; B = 0; end
1: begin R = 100; G = 0; B = 40; end
2: begin R = 0; G = 0; B = 0; end
3: begin R = 100; G = 0; B = 60; end
4: begin R = 0; G = 0; B = 0;end
5: begin R = 100; G = 0; B = 80; end
6: begin R = 0; G = 0; B = 0;end
7: begin R = 100; G = 0; B = 100; end
8: begin R = 0; G = 0; B = 0;end
9: begin R = 0; G = 0; B = 100; end
10: begin R = 0; G = 0; B = 0;end
11: begin R = 0; G = 0; B = 100; end
12: begin R = 0; G = 0; B = 0; end
13: begin R = 20; G = 0; B = 100; end
14: begin R = 0; G = 0; B = 0; end
15: begin R = 40; G = 0; B = 100; end
16: begin R = 0; G = 0; B = 0; end
17: begin R = 60; G = 0; B = 100; end
18: begin R = 0; G = 0; B = 0; end
19: begin R = 80; G = 0; B = 100; end
20: begin R = 0; G = 0; B = 0; end
21: begin R = 100; G = 0; B = 100; end
22: begin R = 0; G = 0; B = 0; end
23: begin R = 100; G = 0; B = 0; end

24: begin R = 0; G = 0; B = 0; end
25: begin R = 0; G = 100; B = 0; end
26: begin R = 0; G = 0; B = 0; end
27: begin R = 10; G = 100; B = 0; end
28: begin R = 0; G = 0; B = 0; end
29: begin R = 20; G = 100; B = 0; end
30: begin R = 0; G = 0; B = 0; end
31: begin R = 40; G = 100; B = 0; end
32: begin R = 0; G = 0; B = 0; end
33: begin R = 60; G = 100; B = 0; end
34: begin R = 0; G = 0; B = 0; end
35: begin R = 80; G = 100; B = 0; end
36: begin R = 0; G = 0; B = 0; end
37: begin R = 100; G = 100; B = 0; end

38: begin R = 0; G = 0; B = 0; end
39: begin R = 100; G = 100; B = 0; end
40: begin R = 0; G = 0; B = 0; end
41: begin R = 90; G = 100; B = 10; end
42: begin R = 0; G = 0; B = 0; end
43: begin R = 80; G = 100; B = 20; end
44: begin R = 0; G = 0; B = 0; end
45: begin R = 60; G = 100; B = 40; end
46: begin R = 0; G = 0; B = 0; end
47: begin R = 40; G = 100; B = 60; end
48: begin R = 0; G = 0; B = 0; end
49: begin R = 20; G = 100; B = 80; end
50: begin R = 0; G = 0; B = 0; end
51: begin R = 0; G = 100; B = 100; end

52: begin R = 0; G = 0; B = 0; end
53: begin R = 100; G = 100; B = 0; end
54: begin R = 0; G = 0; B = 0; end
55: begin R = 100; G = 100; B = 0; end
56: begin R = 0; G = 0; B = 0; end
57: begin R = 100; G = 0; B = 20; end
58: begin R = 0; G = 0; B = 0; end
59: begin R = 100; G = 0; B = 40; end
60: begin R = 0; G = 0; B = 0; end
61: begin R = 100; G = 0; B = 60; end
62: begin R = 0; G = 0; B = 0; end
63: begin R = 100; G = 0; B = 80; end
64: begin R = 0; G = 0; B = 0; end
65: begin R = 100; G = 0; B = 100; end

66: begin R = 0; G = 0; B = 0; end
67: begin R = 0; G = 100; B = 100; end
68: begin R = 0; G = 0; B = 0; end
69: begin R = 0; G = 100; B = 100; end
70: begin R = 0; G = 0; B = 0; end
71: begin R = 20; G = 0; B = 100; end
72: begin R = 0; G = 0; B = 0; end
73: begin R = 40; G = 0; B = 100; end
74: begin R = 0; G = 0; B = 0; end
75: begin R = 60; G = 0; B = 100; end
76: begin R = 0; G = 0; B = 0; end
77: begin R = 80; G = 0; B = 100; end
78: begin R = 0; G = 0; B = 0; end
79: begin R = 100; G = 0; B = 100; end

80: begin R = 0; G = 0; B = 0; end
81: begin R = 0; G = 100; B = 100; end
82: begin R = 0; G = 0; B = 0; end
83: begin R = 100; G = 100; B = 0; end
84: begin R = 0; G = 0; B = 0; end
85: begin R = 100; G = 0; B = 100; end
86: begin R = 0; G = 0; B = 0; end
87: begin R = 0; G = 0; B = 100; end
88: begin R = 0; G = 0; B = 0; end
89: begin R = 100; G = 0; B = 0; end
90: begin R = 0; G = 0; B = 0; end
91: begin R = 0; G = 100; B = 0; end
92: begin R = 0; G = 0; B = 0; end
93: begin R = 100; G = 100; B = 100; end

94: begin R = 0; G = 0; B = 0; end
95: begin R = 100; G = 0; B = 0; end
96: begin R = 0; G = 0; B = 0; end
97: begin R = 0; G = 0; B = 100; end
98: begin R = 0; G = 0; B = 0; end
default: begin R = 100; G = 100; B = 100; end
endcase
end
endmodule

