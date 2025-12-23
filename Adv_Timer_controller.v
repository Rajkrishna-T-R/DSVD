`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 19:49:45
// Design Name: 
// Module Name: Adv_Timer_controller
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


module Adv_Timer_controller(

    input clk,
    input rst,
    input ped,
    output reg timer_out,
    output reg ped_cross_on
    );
    
  
    
    parameter counter_bit=8;
    parameter ped_counter_bit=6;
    
    reg [counter_bit-1:0]count;         // normal count
    reg [ped_counter_bit-1:0]ped_count; //  pedestrian count
       
       always@(*)
            begin
                if(ped_count!=0)
                    begin
                        ped_cross_on=1'b1;
                    end
                else
                    begin
                        ped_cross_on=1'b0;
                    end
                    
            end       
       
       
       
       always@(posedge clk)
            begin
            
                if(rst==1'b1) // reset all the count
                     begin 
                     
                        count<=0;  // reset the count
                        
                        ped_count<=0; // Ped_count reset
                        
                     end
               
               
               else if(ped_count==0 && ped==1'b1) 
               // if ped_count is zero only then  reinitialize it to 15 
               // when button is pressed
               // Continuous overlapping button pressing can be avoided this way
               
                      begin
                      
                        ped_count<=15;  // set the pedestrian crossing timer count
                        
                        count<=count;   // Hold the normal count 
                        
                      end
    
                else if(ped_count!=0) 
                
             // if pedestrian count not zero, decrement the count till it reaches zero
                    begin
                        ped_count<=ped_count-1; // decrement the pedestrian count
                        count<=count;           // Hold the normal count
                    end
                    
                else if(count==64 && ped_count==0)
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
               
                if(count==30||count==60||count==64)
                // RED--> GREEN--> YELLOW (3 normal states)
                // Points of the transitions of normal state 
                    begin
                        if(ped_count!=0) 
                        // making sure at PED state the state transition of the normal 
                        // States will not occur
                            begin
                                timer_out=1'b0;
                                // no state transition when the state is PED state
                            end
                         else
                            begin
                                timer_out=1'b1; 
                                // if ped_count=0,It is sure that the current state
                                // is not the PED state, so ok to make transitions 
                                //across the normal states
                            end 
                    end
                    
                else 
                    begin
                    
                        timer_out=1'b0; 
                        // Dont make any state transitions if the 
                        // timing of the correct transitions is not met
                    end
                    
             end
             
endmodule