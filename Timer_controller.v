
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 18:46:35
// Design Name: 
// Module Name: Timer_controller
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
// RED 30s GREEN 30s YELLOW 4s

module Timer_controller(
    input clk,
    input rst,
    output reg timer_out
    );
    
    parameter counter_bit=8;
    
    reg [counter_bit-1:0]count;
       
       always@(posedge clk)
            begin
            
                if(rst==1'b1)
                     begin 
                        count<=0;
                     end
                     
                else if(count==64)
                    begin
                        count<=0;
                    end
                else 
                    begin
                        count<=count+1;
                    end
             end
         
   always@(*)
            begin
                if(count==30||count==60||count==64 )
                    begin
                       timer_out=1'b1;
                    end
                else 
                    begin
                        timer_out=1'b0;
                    end
             end
             
endmodule
                      