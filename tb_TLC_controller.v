`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 18:58:29
// Design Name: 
// Module Name: tb_TLC_controller
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


module tb_TLC_controller;


parameter clock_period = 10; // 10 ns
reg clk;
reg rst;
wire red,green,yellow;

task  reset;
    
        begin    
            rst=1'b1;
            #(clock_period);
            rst=1'b0;
        end
    endtask
    
    
    
initial
    begin
        clk=0;
        
        rst=1'b1;
        #(clock_period);
        rst=1'b0;
        
       forever #5 clk=~clk;
    end
    
    



TM_TLC uut(

             .clk(clk),
             .rst(rst),
             .red(red),
             .green(green),
             .yellow(yellow)
    );
    
    
    initial 
        begin
            #100;
            reset();
            #500;
            reset();
            #100;
            $finish;
        end

endmodule
