`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 22:29:30
// Design Name: 
// Module Name: TM_Adv_TL
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


module TM_Adv_TL(
        input  wire clk,
        input  wire rst,
        input  wire ped,
        output wire red,
        output wire green,
        output wire yellow,
        output wire ped_green,
        output wire ped_red
    );
    
    wire timer_out;
    wire ped_cross_on;
    
    Adv_Timer_controller ATC
                    (
                    .clk(clk),
                    .rst(rst),
                    .ped(ped),
                    .timer_out(timer_out),
                    .ped_cross_on(ped_cross_on)
                    );
                    
    Adv_TL TLC
           (
            .ped(ped),
            .RST(rst),
            .clk(clk),
            .change_st(timer_out),
            .ped_cross_on(ped_cross_on),
            .red_light(red),
            .green_light(green),
            .yellow_light(yellow),
            .pedest_green(ped_green),
            .pedest_red(ped_red) 
           );
    
        
    
endmodule
