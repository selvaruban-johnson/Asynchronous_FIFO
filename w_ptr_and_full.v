`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2020 08:16:52 PM
// Design Name: 
// Module Name: w_ptr_and_full
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


module w_ptr_and_full(output reg full, output reg [4:0]wr_addr,output reg [5:0]wr_ptr, 
input wr_en,wr_rst,wr_clk, 
input [5:0]wq2_rptr);
reg [5:0]wr_count;
//wire [3:0]wr_ptr1;

//binary_to_gray b1 (.count(wr_count),.gray(wr_ptr1));

always @ (posedge wr_clk,posedge wr_rst)
begin
    if(wr_rst)
    begin
        full<=0;
        wr_addr<=0;
        wr_ptr<=0;
        wr_count<=0;
    end
    else 
    begin
        if((wr_ptr[5]!=wq2_rptr[5])&&(wr_ptr[4]!=wq2_rptr[4])&&(wr_ptr[3:0]==wq2_rptr[3:0]))
        begin
            full<=1;
        end
        else
        begin
            full<=0;
            wr_count<=wr_count + (wr_en & ~full);
            wr_ptr <= {wr_count[5],wr_count[5:1]^wr_count[5:0]};
            wr_addr <= wr_count[4:0];
        end
        
    end
end
endmodule
