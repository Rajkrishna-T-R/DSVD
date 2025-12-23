`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2025 12:26:04
// Design Name: 
// Module Name: Traffic_Light
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
//---------------------------------------------------------//
// Sequence of the transitions
//---------------------------------------------------------//
// RED --> GREEN --> YELLOW
//---------------------------------------------------------//

module Traffic_Light(
        input RST,
        input clk,
        input change_st,
        output reg red_light,
        output reg green_light,
        output reg yellow_light
    );
    reg [2:0] curr_st;
    reg [2:0] next_st;
    
    parameter RED=3'b000;
    parameter YELLOW=3'b001;
    parameter GREEN = 3'b010;
    
    
    always@(posedge clk)
        begin
            if(RST==1'b1)
                begin
                    curr_st<=RED;
                end
            else 
                begin
                    curr_st<=next_st;
                end
                
        end
        
        
     always@(*)
        begin
            case(curr_st)
                
                    RED: begin
                    
                           if(change_st==1'b1)
                               begin
                                next_st=GREEN;
                               end
                           else 
                                begin
                                    next_st=curr_st;
                                end                       
                         end
                         
                    YELLOW:begin
                                if(change_st==1'b1)
                                   begin
                                        next_st=RED;
                                   end  
                               else 
                                    begin
                                        next_st=curr_st;
                                    end  
                           end
                    GREEN : begin
                                   if(change_st==1'b1)
                                       begin
                                            next_st=YELLOW;
                                       end   
                                   else 
                                        begin
                                            next_st=curr_st;
                                        end 
                            end
                    default: begin
                                next_st=RED;
                             end
                             
                    endcase
                    
          end
      always@(*)
      
            begin
                case(curr_st)
                      RED:  begin
                                red_light=1'b1;
                                green_light=1'b0;
                                yellow_light=1'b0;
                            end
                      GREEN:begin
                                red_light=1'b0;
                                green_light=1'b1;
                                yellow_light=1'b0;
                            end
                      YELLOW:begin
                                red_light=1'b0;
                                green_light=1'b0;
                                yellow_light=1'b1;
                             end
                      default: begin
                                  red_light=1'b1;
                                  green_light=1'b0;
                                  yellow_light=1'b0;
                               end
                             
                    endcase    
               end       
                           
endmodule
