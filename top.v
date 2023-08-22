// Change "id" to the id of your wokwi design on the following two lines:
`include "tt_um_wokwi_id.v"
`define WOKWI_MODULE_NAME tt_um_wokwi_id 

`define default_netname none

module top(
    input [7:0] ui_in,    // Dedicated inputs
    output [7:0] uo_out,  // Dedicated outputs
    inout [7:0] uio,      // Bidirectional pins
    input clk_pin,
    input rst_n_pin 
);

    wire [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    wire clk;
    wire rst_n;

    WOKWI_MODULE_NAME wokwi_design (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_oe(uio_out),
        .uio_oe(uio_oe),
        .clk(clk),
        .rst_n(rst_n)
    );

    SB_IO #(
        .PIN_TYPE(6'b 1010_01),
        .PULLUP(1'b 0)	// Pull up enable for all bidirectional io
    ) _uio [7:0] (
        .PACKAGE_PIN({uio[0], uio[1], uio[2], uio[3], uio[4], uio[5], uio[6], uio[7]}),
        .OUTPUT_ENABLE({uio_oe[0], uio_oe[1], uio_oe[2], uio_oe[3], uio_oe[4], uio_oe[5], uio_oe[6], uio_oe[7]}),
        .D_OUT_0({uio_out[0], uio_out[1], uio_out[2], uio_out[3], uio_out[4], uio_out[5], uio_out[6], uio_out[7]}),
        .D_IN_0({uio_in[0], uio_in[1], uio_in[2], uio_in[3], uio_in[4], uio_in[5], uio_in[6], uio_in[7]})
    );

    // Make clock global
    SB_GB_IO #(
        .PIN_TYPE(6'b 0000_01)
    ) global_clk (
        .PACKAGE_PIN(clk_pin),
        .GLOBAL_BUFFER_OUTPUT(clk)
    );

    // Make reset global
    SB_GB_IO #(
        .PIN_TYPE(6'b 0000_01)
    ) global_rst_n (
        .PACKAGE_PIN(rst_n_pin),
        .GLOBAL_BUFFER_OUTPUT(rst_n)
    );

endmodule