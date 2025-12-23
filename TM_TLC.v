
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 18:53:39
// Design Name: 
// Module Name: TM_TLC
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


module TM_TLC(

            input wire  clk,
            input wire rst,
            output wire red,
            output wire green,
            output wire yellow
    );
    wire timer_out;
    
    Timer_controller TLC(
    .clk(clk),
    .rst(rst),
    .timer_out(timer_out)
    );
    
    Traffic_Light TL(
        .RST(rst),
        .clk(clk),
        .change_st(timer_out),
        .red_light(red),
        .green_light(green),
        .yellow_light(yellow)
    );
    
    
    
    
    
endmodule
