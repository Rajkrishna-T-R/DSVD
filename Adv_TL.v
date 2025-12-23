`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 19:42:07
// Design Name: 
// Module Name: Adv_TL
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


module Adv_TL(
        
        input ped,
        input RST,
        input clk,
        input change_st,
        input ped_cross_on,
        output reg red_light,
        output reg green_light,
        output reg yellow_light,
        output reg pedest_green,
        output reg pedest_red
    );
    reg [2:0] curr_st;
    reg [2:0] next_st;
    reg [2:0] prev_st;
    
    parameter RED=3'b000;          // RED
    parameter YELLOW=3'b001;       // YELLOW
    parameter GREEN = 3'b010;      // GREEN
    parameter PED = 3'b011;        // PEDESTRIAN
    
    
    
    
    always@(posedge clk)
        begin
            if(RST==1'b1)
                begin
                    curr_st<=RED;
                    prev_st<=RED;
                end
                
             else
                 begin
                     
                    curr_st<=next_st;
                     
                 //   prev_st<=curr_st;
                    if((next_st==PED) && (curr_st!=PED))
                        begin
                            prev_st<=curr_st;
                        end
                     
                 end
             
        end
        
        
     always@(*)
        begin
            case(curr_st)
                    
                    PED: begin
                            if(ped_cross_on!=0)
                                        begin
                                            next_st=PED; 
                                            // stay at ped state if timer not zero
                                            // indication given by the ' ped_cross_on ' signal  
                                        end
                                   
                            else if(ped_cross_on==0)
                                        begin
                                            next_st=prev_st; 
                                            // return to the previous state after pedestrian cross is done
                                        end
                         end
                            
                    RED: begin
                    
                           
                           if(ped_cross_on!=0)
                                        begin
                                            next_st=PED; 
                                            // stay at ped state if timer not zero
                                            // indication given by the ' ped_cross_on ' signal  
                                        end
                                        
                          else if(change_st==1'b1)
                               begin
                                next_st=GREEN;
                               end
                           else 
                                begin
                                    next_st=curr_st;
                                end                       
                         end
                         
                    YELLOW:begin
                              if(ped_cross_on!=0)
                                        begin
                                            next_st=PED; 
                                            // stay at ped state if timer not zero
                                            // indication given by the ' ped_cross_on ' signal  
                                        end
                              
                               else if(change_st==1'b1)
                                   begin
                                        
                                        next_st=RED;
                                   end  
                                 
                               else 
                                    begin
                                        next_st=curr_st;
                                    end  
                           end
                    GREEN : begin
                                if(ped_cross_on!=0)
                                        begin
                                            next_st=PED; 
                                            // stay at ped state if timer not zero
                                            // indication given by the ' ped_cross_on ' signal  
                                        end
                                
                                
                                 else  if(change_st==1'b1)
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
                                pedest_red=1'b1;
                                pedest_green=1'b0;
                            end
                      GREEN:begin
                                red_light=1'b0;
                                green_light=1'b1;
                                yellow_light=1'b0;
                                pedest_red=1'b1;
                                pedest_green=1'b0;
                            end
                      YELLOW:begin
                                red_light=1'b0;
                                green_light=1'b0;
                                yellow_light=1'b1;
                                pedest_red=1'b1;
                                pedest_green=1'b0;
                             end
                      PED:   begin
                                red_light=1'b1;
                                green_light=1'b0;
                                yellow_light=1'b0;
                                pedest_red=1'b0;
                                pedest_green=1'b1;
                             end
                      default: begin
                                  red_light=1'b1;
                                  green_light=1'b0;
                                  yellow_light=1'b0;
                                  pedest_red=1'b1;
                                  pedest_green=1'b0;
                               end
                             
                    endcase    
               end       
                           
endmodule
