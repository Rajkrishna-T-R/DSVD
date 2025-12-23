`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2025 22:37:16
// Design Name: 
// Module Name: Tb_Adv_TLC
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


module Tb_Adv_TLC;

   

parameter clock_period = 10; // 10 ns

reg ped;
reg clk;
reg rst;
wire red,green,yellow,ped_green,ped_red;


TM_Adv_TL uut(
         .clk(clk),
         .rst(rst),
         .ped(ped),
            .red(red),
            .green(green),
            .yellow(yellow),
            .ped_green(ped_green),
            .ped_red(ped_red)
    );


// Task for reseting 
task  reset;
        begin    
            rst=1'b1;
            #(clock_period);
            rst=1'b0;
        end
    endtask

// Task for pedestrian crossing
task pedestrian;
       begin
            ped=1'b1;
            #(clock_period);
            ped=1'b0;
       end
    endtask
       
       
    
 // Testbench body  clock generation and initialization  
initial
    begin
        clk=0;
        ped=0;
        rst=1'b1;
        #(clock_period);
        rst=1'b0;
        
       forever #5 clk=~clk;
    end
    
    




 // Test sequence  
    initial 
        begin
            #100;
            reset();
            #500;
            reset();
            #350;
            pedestrian();
            #200;
            reset();
            #300;
            pedestrian();
            #100;
            $finish;
        end

endmodule
