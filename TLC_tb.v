`include "traffic_light.v"
`timescale 1ns/1ns

module traffic_light_tb ();
    // testbench variables
    reg clk, C, rst_n;
    wire [2:0] light_farm, light_highway;

    // Module instantiation
    traffic_light dut (
        .clk(clk),
        .C(C),
        .rst_n(rst_n),
        .light_farm(light_farm),
        .light_highway(light_highway)
    );

    // 50 MHz Clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Simulation
    initial begin
        $dumpfile("TLC.vcd");
        $dumpvars(0, traffic_light_tb);
        $monitor("Sensor: %b, Highway Light: %b, Farm Light: %b", C, light_highway, light_farm);

        #2
        rst_n = 0;
        #20
        rst_n = 1; C = 0;
        #20
        C = 1;
        #50
        C = 0;
        #300
        C = 1;
        #20
        C = 0;
        #500
   

        $display("Test Complete!!!");
        $finish;

    end

endmodule;