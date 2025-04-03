`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2024 12:03:00 PM
// Design Name: 
// Module Name: voteLogger
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


module voteLogger(
input clock,
input reset,
input mode,
input cand1_vote_valid,
input cand2_vote_valid,
input cand3_vote_valid,
input cand4_vote_valid,
output reg [7:0] cand1_vote_recvd,
output reg [7:0] cand2_vote_recvd,
output reg [7:0] cand3_vote_recvd,
output reg [7:0] cand4_vote_recvd,
output reg [2:0] lead,
output reg [2:0] lead2
);


always @(posedge clock)
begin
    if(reset)
    begin
        cand1_vote_recvd <= 0;
        cand2_vote_recvd <= 0;
        cand3_vote_recvd <= 0;
        cand4_vote_recvd <= 0;
    end
    else
    begin
        if(cand1_vote_valid & mode==0)
            cand1_vote_recvd <= cand1_vote_recvd + 1;
        else if(cand2_vote_valid & mode==0)
            cand2_vote_recvd <= cand2_vote_recvd + 1;
        else if(cand3_vote_valid & mode==0)
            cand3_vote_recvd <= cand3_vote_recvd + 1;
        else if(cand4_vote_valid & mode==0)
            cand4_vote_recvd <= cand4_vote_recvd + 1;
    end
end
always @ (posedge clock)
begin
    if (reset)
        lead=3'd0;
    else if (mode)
        if (cand1_vote_recvd > cand2_vote_recvd)
             if (cand1_vote_recvd > cand3_vote_recvd)
                  if(cand1_vote_recvd > cand4_vote_recvd)
                       lead=3'd1;
                   else
                         lead=3'd4;
             else  if(cand3_vote_recvd > cand4_vote_recvd)
                    lead=3'd3;
             else
                    lead=3'd4;
         else if (cand2_vote_recvd > cand3_vote_recvd)
              if (cand2_vote_recvd > cand4_vote_recvd)
                    lead=3'd2;
              else
                    lead=3'd4;
          else if (cand3_vote_recvd > cand4_vote_recvd)
                    lead=3'd3;
          else
                    lead=3'd4;
end
always @ (posedge clock)
begin
if (reset)
	lead2=3'd0;
else if (lead==3'd1 & mode==1)
	if (cand1_vote_recvd==cand2_vote_recvd)
		lead2=3'd2;
    else if (cand1_vote_recvd==cand3_vote_recvd)
		lead2=3'd3;
    else if (cand1_vote_recvd==cand4_vote_recvd)
		lead2=3'd4;
	else 
         lead2=3'd0;
else if (lead==3'd2 & mode==1)
	if (cand2_vote_recvd==cand1_vote_recvd)
		lead2=3'd1;
    else if (cand2_vote_recvd==cand3_vote_recvd)
		lead2=3'd3;
    else if (cand2_vote_recvd==cand4_vote_recvd)
		lead2=3'd4;
	else 
        lead2=3'd0;
else if (lead==3'd3 & mode==1)
	if (cand3_vote_recvd==cand1_vote_recvd)
		lead2=3'd1;
    else if (cand3_vote_recvd==cand2_vote_recvd)
		lead2=3'd2;
    else if (cand3_vote_recvd==cand4_vote_recvd)
		lead2=3'd4;
	else 
         lead2=3'd0;
else if (lead==3'd4 & mode==1)
	if (cand4_vote_recvd==cand1_vote_recvd)
		lead2=3'd1;
    else if (cand4_vote_recvd==cand2_vote_recvd)
		lead2=3'd2;
    else if (cand4_vote_recvd==cand3_vote_recvd)
		lead2=3'd3;
    else 
	     lead2=3'd0;
end

endmodule
