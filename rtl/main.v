`timescale	1ps / 1ps
////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./main.v
//
// Project:	ZipVersa, Versa Brd implementation using ZipCPU infrastructure
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	autofpga autofpga -d -o . allclocks.txt global.txt dlyarbiter.txt version.txt buserr.txt pwrcount.txt wbfft.txt spio.txt gpio.txt wbuconsole.txt bkram.txt flash.txt picorv.txt pic.txt mdio1.txt enet.txt enetscope.txt flashscope.txt mem_flash_bkram.txt mem_bkram_only.txt
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2019, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none
//
//
// Here is a list of defines which may be used, post auto-design
// (not post-build), to turn particular peripherals (and bus masters)
// on and off.  In particular, to turn off support for a particular
// design component, just comment out its respective `define below.
//
// These lines are taken from the respective @ACCESS tags for each of our
// components.  If a component doesn't have an @ACCESS tag, it will not
// be listed here.
//
// First, the independent access fields for any bus masters
`define	WBUBUS_MASTER
`define	INCLUDE_PICORV
// And then for the independent peripherals
`define	NET1_ACCESS
`define	NETCTRL1_ACCESS
`define	BKRAM_ACCESS
`define	BUSCONSOLE_ACCESS
`define	FLASH_ACCESS
`define	SPIO_ACCESS
`define	BUSPIC_ACCESS
`define	PWRCOUNT_ACCESS
`define	GPIO_ACCESS
`define	WBFFT_ACCESS
//
//
// The list of those things that have @DEPENDS tags
//
//
//
// Dependencies
// Any core with both an @ACCESS and a @DEPENDS tag will show up here.
// The @DEPENDS tag will turn into a series of ifdef's, with the @ACCESS
// being defined only if all of the ifdef's are true//
`ifdef	FLASH_ACCESS
`define	FLASHCFG_ACCESS
`endif	// FLASH_ACCESS
`ifdef	FLASH_ACCESS
`define	FLASHSCOPE_SCOPC
`endif	// FLASH_ACCESS
`ifdef	INCLUDE_PICORV
`define	INCLUDE_CPU
`endif	// INCLUDE_PICORV
`ifdef	NET1_ACCESS
`define	NETSCOPE_SCOPE
`endif	// NET1_ACCESS
//
// End of dependency list
//
//
//
//
// Finally, we define our main module itself.  We start with the list of
// I/O ports, or wires, passed into (or out of) the main function.
//
// These fields are copied verbatim from the respective I/O port lists,
// from the fields given by @MAIN.PORTLIST
//
module	main(i_clk, i_reset,
		// Ethernet control (packets) lines
		o_net1_reset_n,
		// eth_int_b	// Interrupt, leave floating
		// eth_pme_b	// Power management event, leave floating
		i_net1_rx_clk, i_net1_rx_dv, i_net1_rx_err, i_net1_rxd,
		o_net1_tx_clk, o_net1_tx_ctl, o_net1_txd,
		// The ethernet MDIO1 wires
		o_net1_mdc, o_mdio1, o_mdio1_we, i_mdio1,
		// The Universal QSPI Flash
		o_qspi_cs_n, o_qspi_sck, o_qspi_dat, i_qspi_dat, o_qspi_mod,
		// SPIO interface
		i_sw, i_btn, o_led,
		// Network clock at 125MHz
		i_clk_125mhz,
		// UART/host to wishbone interface
		i_wbu_uart_rx, o_wbu_uart_tx,
		// GPIO ports
		i_gpio, o_gpio);
//
// Any parameter definitions
//
// These are drawn from anything with a MAIN.PARAM definition.
// As they aren't connected to the toplevel at all, it would
// be best to use localparam over parameter, but here we don't
// check
	localparam	[31-1:0]	RESET_ADDRESS = 10485760,
				STACKADDR = 10551296;
//
// The next step is to declare all of the various ports that were just
// listed above.  
//
// The following declarations are taken from the values of the various
// @MAIN.IODECL keys.
//
	input	wire		i_clk;
	// verilator lint_off UNUSED
	input	wire		i_reset;
	// verilator lint_on UNUSED
	// Ethernet (RGMII) control
	output	wire		o_net1_reset_n;
	input	wire		i_net1_rx_clk, i_net1_rx_dv, i_net1_rx_err;
	input	wire	[7:0]	i_net1_rxd;
	output	wire	[1:0]	o_net1_tx_clk;
	output	wire		o_net1_tx_ctl;
	output	wire	[7:0]	o_net1_txd;
	// Ethernet control (MDIO1)
	output	wire		o_net1_mdc, o_mdio1, o_mdio1_we;
	input	wire		i_mdio1;
	// The Universal QSPI flash
	output	wire		o_qspi_cs_n, o_qspi_sck;
	output	wire	[3:0]	o_qspi_dat;
	input	wire	[3:0]	i_qspi_dat;
	output	wire	[1:0]	o_qspi_mod;
	// SPIO interface
	input	wire	[8-1:0]	i_sw;
	input	wire	[1-1:0]	i_btn;
	output	wire	[8-1:0]	o_led;
		// Extra clocks
	input	wire		i_clk_125mhz;
	input	wire		i_wbu_uart_rx;
	output	wire		o_wbu_uart_tx;
	localparam	NGPI = 2, NGPO=3;
	// GPIO ports
	input		[(NGPI-1):0]	i_gpio;
	output	wire	[(NGPO-1):0]	o_gpio;
	// Make Verilator happy ... defining bus wires for lots of components
	// often ends up with unused wires lying around.  We'll turn off
	// Ver1lator's lint warning here that checks for unused wires.
	// verilator lint_off UNUSED



	//
	// Declaring interrupt lines
	//
	// These declarations come from the various components values
	// given under the @INT.<interrupt name>.WIRE key.
	//
	wire	flashdbg_int;	// flashdbg.INT.FLASHDBG.WIRE
	wire	net1tx_int;	// net1.INT.NETTX.WIRE
	wire	net1rx_int;	// net1.INT.NETRX.WIRE
	wire	uarttxf_int;	// uart.INT.UARTTXF.WIRE
	wire	uartrxf_int;	// uart.INT.UARTRXF.WIRE
	wire	uarttx_int;	// uart.INT.UARTTX.WIRE
	wire	uartrx_int;	// uart.INT.UARTRX.WIRE
	wire	spio_int;	// spio.INT.SPIO.WIRE
	wire	enetscope_int;	// enetscope.INT.ENETSCOPE.WIRE
	wire	gpio_int;	// gpio.INT.GPIO.WIRE


	//
	// Component declarations
	//
	// These declarations come from the @MAIN.DEFNS keys found in the
	// various components comprising the design.
	//
// Looking for string: MAIN.DEFNS
	//
	wire		net1_debug_clk;
	wire	[31:0]	net1_debug;
	// Console definitions
	wire	w_console_rx_stb, w_console_tx_stb, w_console_busy;
	wire	[6:0]	w_console_rx_data, w_console_tx_data;
	// Definitions for the flash debug port
	wire		flash_dbg_trigger;
	wire	[31:0]	flash_debug;
// BUILDTIME doesnt need to include builddate.v a second time
// `include "builddate.v"
	wire	[8-1:0]	w_led;
	wire	net1_dbg_trigger;
	wire	w_bus_int;
	reg	[31:0]	r_pwrcount_data;
	wire	i_net_tx_clk;
	reg	[23-1:0]	r_buserr_addr;
	//
	//
	// UART interface
	//
	//
	// Baudrate :   1000000
	// Clock    :  50000000
	localparam [23:0] BUSUART = 24'h32;	// 1000000 baud
	wire	[7:0]	wbu_rx_data, wbu_tx_data;
	wire		wbu_rx_stb;
	wire		wbu_tx_stb, wbu_tx_busy;

	wire	w_ck_uart, w_uart_tx;
	// Definitions for the WB-UART converter.  We really only need one
	// (more) non-bus wire--one to use to select if we are interacting
	// with the ZipCPU or not.
	wire	[0:0]	wbubus_dbg;
`ifndef	INCLUDE_ZIPCPU
	//
	// The bus-console depends upon the zip_dbg wires.  If there is no
	// ZipCPU defining them, we'll need to define them here anyway.
	//
	wire		zip_dbg_ack, zip_dbg_stall;
	wire	[31:0]	zip_dbg_data;
`endif
	// Bus arbiter's internal lines
	wire		wbu_delayi_cyc, wbu_delayi_stb, wbu_delayi_we,
			wbu_delayi_ack, wbu_delayi_stall, wbu_delayi_err;
	wire	[(23-1):0]	wbu_delayi_addr;
	wire	[(32-1):0]	wbu_delayi_odata, wbu_delayi_idata;
	wire	[(4-1):0]	wbu_delayi_sel;
`include "builddate.v"
	wire		picorv_trap;
	wire	[31:0]	cpu_addr_wide;
	wire		wbfft_int;


	//
	// Declaring interrupt vector wires
	//
	// These declarations come from the various components having
	// PIC and PIC.MAX keys.
	//
	wire	[14:0]	bus_int_vector;
	wire	[31:0]	picorv_int_vec;
	//
	//
	// Define bus wires
	//
	//

	// Bus wb
	// Wishbone master wire definitions for bus: wb
	wire		wb_cyc, wb_stb, wb_we, wb_stall, wb_err,
			wb_none_sel;
	reg		wb_many_ack;
	wire	[22:0]	wb_addr;
	wire	[31:0]	wb_data;
	reg	[31:0]	wb_idata;
	wire	[3:0]	wb_sel;
	reg		wb_ack;

	// Wishbone slave definitions for bus wb(SIO), slave buildtime
	wire		buildtime_sel, buildtime_ack, buildtime_stall;
	wire	[31:0]	buildtime_data;

	// Wishbone slave definitions for bus wb(SIO), slave buserr
	wire		buserr_sel, buserr_ack, buserr_stall;
	wire	[31:0]	buserr_data;

	// Wishbone slave definitions for bus wb(SIO), slave buspic
	wire		buspic_sel, buspic_ack, buspic_stall;
	wire	[31:0]	buspic_data;

	// Wishbone slave definitions for bus wb(SIO), slave gpio
	wire		gpio_sel, gpio_ack, gpio_stall;
	wire	[31:0]	gpio_data;

	// Wishbone slave definitions for bus wb(SIO), slave pwrcount
	wire		pwrcount_sel, pwrcount_ack, pwrcount_stall;
	wire	[31:0]	pwrcount_data;

	// Wishbone slave definitions for bus wb(SIO), slave spio
	wire		spio_sel, spio_ack, spio_stall;
	wire	[31:0]	spio_data;

	// Wishbone slave definitions for bus wb(SIO), slave version
	wire		version_sel, version_ack, version_stall;
	wire	[31:0]	version_data;

	// Wishbone slave definitions for bus wb, slave flashcfg
	wire		flashcfg_sel, flashcfg_ack, flashcfg_stall;
	wire	[31:0]	flashcfg_data;

	// Wishbone slave definitions for bus wb, slave enetscope
	wire		enetscope_sel, enetscope_ack, enetscope_stall;
	wire	[31:0]	enetscope_data;

	// Wishbone slave definitions for bus wb, slave flashdbg
	wire		flashdbg_sel, flashdbg_ack, flashdbg_stall;
	wire	[31:0]	flashdbg_data;

	// Wishbone slave definitions for bus wb, slave uart
	wire		uart_sel, uart_ack, uart_stall;
	wire	[31:0]	uart_data;

	// Wishbone slave definitions for bus wb, slave net1
	wire		net1_sel, net1_ack, net1_stall;
	wire	[31:0]	net1_data;

	// Wishbone slave definitions for bus wb, slave wb_sio
	wire		wb_sio_sel, wb_sio_ack, wb_sio_stall;
	wire	[31:0]	wb_sio_data;

	// Wishbone slave definitions for bus wb, slave mdio1
	wire		mdio1_sel, mdio1_ack, mdio1_stall;
	wire	[31:0]	mdio1_data;

	// Wishbone slave definitions for bus wb, slave netb
	wire		netb_sel, netb_ack, netb_stall;
	wire	[31:0]	netb_data;

	// Wishbone slave definitions for bus wb, slave wbfft
	wire		wbfft_sel, wbfft_ack, wbfft_stall;
	wire	[31:0]	wbfft_data;

	// Wishbone slave definitions for bus wb, slave bkram
	wire		bkram_sel, bkram_ack, bkram_stall;
	wire	[31:0]	bkram_data;

	// Wishbone slave definitions for bus wb, slave flash
	wire		flash_sel, flash_ack, flash_stall;
	wire	[31:0]	flash_data;

	// Bus cpu
	// Wishbone master wire definitions for bus: cpu
	wire		cpu_cyc, cpu_stb, cpu_we, cpu_stall, cpu_err,
			cpu_none_sel;
	reg		cpu_many_ack;
	wire	[22:0]	cpu_addr;
	wire	[31:0]	cpu_data;
	reg	[31:0]	cpu_idata;
	wire	[3:0]	cpu_sel;
	reg		cpu_ack;

	// Wishbone slave definitions for bus cpu, slave cpu_delay
	wire		cpu_delay_sel, cpu_delay_ack, cpu_delay_stall, cpu_delay_err;
	wire	[31:0]	cpu_delay_data;

	// Bus wbu
	// Wishbone master wire definitions for bus: wbu
	wire		wbu_cyc, wbu_stb, wbu_we, wbu_stall, wbu_err,
			wbu_none_sel;
	reg		wbu_many_ack;
	wire	[22:0]	wbu_addr;
	wire	[31:0]	wbu_data;
	reg	[31:0]	wbu_idata;
	wire	[3:0]	wbu_sel;
	reg		wbu_ack;

	// Wishbone slave definitions for bus wbu, slave wbu_delay
	wire		wbu_delay_sel, wbu_delay_ack, wbu_delay_stall, wbu_delay_err;
	wire	[31:0]	wbu_delay_data;


	//
	// Peripheral address decoding
	//
	//
	//
	//
	// Select lines for bus: wb
	//
	// Address width: 23
	// Data width:    32
	//
	//
	
	assign	   buildtime_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h0));  // 0x000000
	assign	      buserr_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h1));  // 0x000004
	assign	      buspic_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h2));  // 0x000008
	assign	        gpio_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h3));  // 0x00000c
	assign	    pwrcount_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h4));  // 0x000010
	assign	        spio_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h5));  // 0x000014
	assign	     version_sel = ((wb_sio_sel)&&(wb_addr[ 2: 0] ==  3'h6));  // 0x000018
	assign	    flashcfg_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h01); // 0x100000
	assign	   enetscope_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h02); // 0x200000 - 0x200007
	assign	    flashdbg_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h03); // 0x300000 - 0x300007
	assign	        uart_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h04); // 0x400000 - 0x40000f
	assign	        net1_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h05); // 0x500000 - 0x50001f
	assign	      wb_sio_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h06); // 0x600000 - 0x60001f
//x2	Was a master bus as well
	assign	       mdio1_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h07); // 0x700000 - 0x70007f
	assign	        netb_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h08); // 0x800000 - 0x800fff
	assign	       wbfft_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h09); // 0x900000 - 0x901fff
	assign	       bkram_sel = ((wb_addr[22:18] &  5'h1f) ==  5'h0a); // 0xa00000 - 0xa0ffff
	assign	       flash_sel = ((wb_addr[22:18] &  5'h10) ==  5'h10); // 0x1000000 - 0x1ffffff
	//

	//
	//
	//
	// Select lines for bus: cpu
	//
	// Address width: 23
	// Data width:    32
	//
	//
	
	assign	   cpu_delay_sel = (cpu_cyc); // Only one peripheral on this bus
	//

	//
	//
	//
	// Select lines for bus: wbu
	//
	// Address width: 23
	// Data width:    32
	//
	//
	
	assign	   wbu_delay_sel = (wbu_cyc); // Only one peripheral on this bus
	//

	//
	// BUS-LOGIC for wb
	//
	assign	wb_none_sel = (wb_stb)&&({
				flashcfg_sel,
				enetscope_sel,
				flashdbg_sel,
				uart_sel,
				net1_sel,
				wb_sio_sel,
				mdio1_sel,
				netb_sel,
				wbfft_sel,
				bkram_sel,
				flash_sel} == 0);

	//
	// many_ack
	//
	// It is also a violation of the bus protocol to produce multiple
	// acks at once and on the same clock.  In that case, the bus
	// can't decide which result to return.  Worse, if someone is waiting
	// for a return value, that value will never come since another ack
	// masked it.
	//
	// The other error that isn't tested for here, no would I necessarily
	// know how to test for it, is when peripherals return values out of
	// order.  Instead, I propose keeping that from happening by
	// guaranteeing, in software, that two peripherals are not accessed
	// immediately one after the other.
	//
	always @(posedge i_clk)
		case({		flashcfg_ack,
				enetscope_ack,
				flashdbg_ack,
				uart_ack,
				net1_ack,
				wb_sio_ack,
				mdio1_ack,
				netb_ack,
				wbfft_ack,
				bkram_ack,
				flash_ack})
			11'b00000000000: wb_many_ack <= 1'b0;
			11'b10000000000: wb_many_ack <= 1'b0;
			11'b01000000000: wb_many_ack <= 1'b0;
			11'b00100000000: wb_many_ack <= 1'b0;
			11'b00010000000: wb_many_ack <= 1'b0;
			11'b00001000000: wb_many_ack <= 1'b0;
			11'b00000100000: wb_many_ack <= 1'b0;
			11'b00000010000: wb_many_ack <= 1'b0;
			11'b00000001000: wb_many_ack <= 1'b0;
			11'b00000000100: wb_many_ack <= 1'b0;
			11'b00000000010: wb_many_ack <= 1'b0;
			11'b00000000001: wb_many_ack <= 1'b0;
			default: wb_many_ack <= (wb_cyc);
		endcase

	reg		r_wb_sio_ack;
	reg	[31:0]	r_wb_sio_data;

	assign	wb_sio_stall = 1'b0;

	initial r_wb_sio_ack = 1'b0;
	always	@(posedge i_clk)
		r_wb_sio_ack <= (wb_stb)&&(wb_sio_sel);
	assign	wb_sio_ack = r_wb_sio_ack;

	always	@(posedge i_clk)
	casez( wb_addr[2:0] )
		3'h0: r_wb_sio_data <= buildtime_data;
		3'h1: r_wb_sio_data <= buserr_data;
		3'h2: r_wb_sio_data <= buspic_data;
		3'h3: r_wb_sio_data <= gpio_data;
		3'h4: r_wb_sio_data <= pwrcount_data;
		3'h5: r_wb_sio_data <= spio_data;
		default: r_wb_sio_data <= version_data;
	endcase
	assign	wb_sio_data = r_wb_sio_data;

	//
	// No class DOUBLE peripherals on the "wb" bus
	//
	//
	// Finally, determine what the response is from the wb bus
	// bus
	//
	//
	//
	// wb_ack
	//
	// The returning wishbone ack is equal to the OR of every component that
	// might possibly produce an acknowledgement, gated by the CYC line.
	//
	// To return an ack here, a component must have a @SLAVE.TYPE tag.
	// Acks from any @SLAVE.TYPE of SINGLE and DOUBLE components have been
	// collected together (above) into wb_sio_ack and wb_dio_ack
	// respectively, which will appear ahead of any other device acks.
	//
	always @(posedge i_clk)
		wb_ack <= (wb_cyc)&&(|{ flashcfg_ack,
				enetscope_ack,
				flashdbg_ack,
				uart_ack,
				net1_ack,
				wb_sio_ack,
				mdio1_ack,
				netb_ack,
				wbfft_ack,
				bkram_ack,
				flash_ack });
	//
	// wb_idata
	//
	// This is the data returned on the bus.  Here, we select between a
	// series of bus sources to select what data to return.  The basic
	// logic is simply this: the data we return is the data for which the
	// ACK line is high.
	//
	// The last item on the list is chosen by default if no other ACK's are
	// true.  Although we might choose to return zeros in that case, by
	// returning something we can skimp a touch on the logic.
	//
	// Any peripheral component with a @SLAVE.TYPE value of either OTHER
	// or MEMORY will automatically be listed here.  In addition, the
	// bus responses from @SLAVE.TYPE SINGLE (_sio_) and/or DOUBLE
	// (_dio_) may also be listed here, depending upon components are
	// connected to them.
	//
	reg [3:0]	r_wb_bus_select;
	always	@(posedge i_clk)
	if (wb_stb && ! wb_stall)
		casez(wb_addr[22:18])
			// 01f00000 & 00100000, flashcfg
			5'b0_0001: r_wb_bus_select <= 4'd0;
			// 01f00000 & 00200000, enetscope
			5'b0_0010: r_wb_bus_select <= 4'd1;
			// 01f00000 & 00300000, flashdbg
			5'b0_0011: r_wb_bus_select <= 4'd2;
			// 01f00000 & 00400000, uart
			5'b0_0100: r_wb_bus_select <= 4'd3;
			// 01f00000 & 00500000, net1
			5'b0_0101: r_wb_bus_select <= 4'd4;
			// 01f00000 & 00600000, wb_sio
			5'b0_0110: r_wb_bus_select <= 4'd5;
			// 01f00000 & 00700000, mdio1
			5'b0_0111: r_wb_bus_select <= 4'd6;
			// 01f00000 & 00800000, netb
			5'b0_1000: r_wb_bus_select <= 4'd7;
			// 01f00000 & 00900000, wbfft
			5'b0_1001: r_wb_bus_select <= 4'd8;
			// 01f00000 & 00a00000, bkram
			5'b0_1010: r_wb_bus_select <= 4'd9;
			// 01000000 & 01000000, flash
			5'b1_????: r_wb_bus_select <= 4'd10;
			default: begin end
		endcase

	always @(posedge i_clk)
	casez(r_wb_bus_select)
		4'd0: wb_idata <= flashcfg_data;
		4'd1: wb_idata <= enetscope_data;
		4'd2: wb_idata <= flashdbg_data;
		4'd3: wb_idata <= uart_data;
		4'd4: wb_idata <= net1_data;
		4'd5: wb_idata <= wb_sio_data;
		4'd6: wb_idata <= mdio1_data;
		4'd7: wb_idata <= netb_data;
		4'd8: wb_idata <= wbfft_data;
		4'd9: wb_idata <= bkram_data;
		4'd10: wb_idata <= flash_data;
		default: wb_idata <= flash_data;
	endcase

	assign	wb_stall =	((flashcfg_sel)&&(flashcfg_stall))
				||((enetscope_sel)&&(enetscope_stall))
				||((flashdbg_sel)&&(flashdbg_stall))
				||((uart_sel)&&(uart_stall))
				||((net1_sel)&&(net1_stall))
				||((wb_sio_sel)&&(wb_sio_stall))
				||((mdio1_sel)&&(mdio1_stall))
				||((netb_sel)&&(netb_stall))
				||((wbfft_sel)&&(wbfft_stall))
				||((bkram_sel)&&(bkram_stall))
				||((flash_sel)&&(flash_stall));

	assign wb_err = ((wb_stb)&&(wb_none_sel))||(wb_many_ack);
	//
	// BUS-LOGIC for cpu
	//
		// Only one peripheral attached
	assign	cpu_none_sel = 1'b0;
	always @(*)
		cpu_many_ack = 1'b0;
	assign	cpu_err = cpu_delay_err;
	assign	cpu_stall = cpu_delay_stall;
	always @(*)
		cpu_ack = cpu_delay_ack;
	always @(*)
		cpu_idata = cpu_delay_data;
	//
	// BUS-LOGIC for wbu
	//
		// Only one peripheral attached
	assign	wbu_none_sel = 1'b0;
	always @(*)
		wbu_many_ack = 1'b0;
	assign	wbu_err = wbu_delay_err;
	assign	wbu_stall = wbu_delay_stall;
	always @(*)
		wbu_ack = wbu_delay_ack;
	always @(*)
		wbu_idata = wbu_delay_data;
	//
	// Declare the interrupt busses
	//
	// Interrupt busses are defined by anything with a @PIC tag.
	// The @PIC.BUS tag defines the name of the wire bus below,
	// while the @PIC.MAX tag determines the size of the bus width.
	//
	// For your peripheral to be assigned to this bus, it must have an
	// @INT.NAME.WIRE= tag to define the wire name of the interrupt line,
	// and an @INT.NAME.PIC= tag matching the @PIC.BUS tag of the bus
	// your interrupt will be assigned to.  If an @INT.NAME.ID tag also
	// exists, then your interrupt will be assigned to the position given
	// by the ID# in that tag.
	//
	assign	bus_int_vector = {
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		enetscope_int,
		spio_int,
		flashdbg_int
	};
	assign	picorv_int_vec = {
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		1'b0,
		gpio_int,
		uartrxf_int,
		uarttxf_int,
		net1rx_int,
		net1tx_int
	};


	//
	//
	// Now we turn to defining all of the parts and pieces of what
	// each of the various peripherals does, and what logic it needs.
	//
	// This information comes from the @MAIN.INSERT and @MAIN.ALT tags.
	// If an @ACCESS tag is available, an ifdef is created to handle
	// having the access and not.  If the @ACCESS tag is `defined above
	// then the @MAIN.INSERT code is executed.  If not, the @MAIN.ALT
	// code is exeucted, together with any other cleanup settings that
	// might need to take place--such as returning zeros to the bus,
	// or making sure all of the various interrupt wires are set to
	// zero if the component is not included.
	//
`ifdef	FLASHSCOPE_SCOPC
	wbscopc #(.LGMEM(13),
		.SYNCHRONOUS(1))
	flashdbgi(i_clk, 1'b1, flash_dbg_trigger, flash_debug[30:0],
		i_clk, wb_cyc, (wb_stb)&&(flashdbg_sel), wb_we,
		wb_addr[0], wb_data, flashdbg_ack, flashdbg_stall,
		flashdbg_data, flashdbg_int);
`else	// FLASHSCOPE_SCOPC
	assign	flashdbg_int = 0;

	// In the case that there is no flashdbg peripheral responding on the wb bus
	assign	flashdbg_stall = 0;
	assign	flashdbg_data  = 0;
	assign	flashdbg_ack   = (wb_stb) && (flashdbg_sel);

	assign	flashdbg_int = 1'b0;	// flashdbg.INT.FLASHDBG.WIRE
`endif	// FLASHSCOPE_SCOPC

`ifndef	NET1_ACCESS
	// Ethernet packet memory declaration
	//
	// The only time this needs to be defined is when the ethernet module
	// itself isnt defined.  Otherwise, the access is accomplished by the
	// ethernet module

	memdev #(11)
		enet_buffers(i_clk,
			(wb_cyc), (wb_stb)&&(netb_sel),
				(wb_we)&&(wb_addr[11-1]),
				wb_addr[11-2:0], wb_data, wb_sel,
				netb_ack, netb_stall, netb_data);

`else

	assign	netb_ack   = 1'b0;
	assign	netb_stall = 1'b0;
	assign	netb_data  = net1_data;

`endif

`ifdef	NET1_ACCESS
	enetpackets	#(.MEMORY_ADDRESS_WIDTH(11))
		net1i(i_clk, i_reset,
			wb_cyc,(wb_stb)&&((net1_sel)||(netb_sel)),
			wb_we, { (netb_sel), wb_addr[11-2:0] }, wb_data, wb_sel,
				net1_ack, net1_stall, net1_data,
			o_net1_reset_n,
			i_net1_rx_clk, i_net1_rx_dv, i_net1_rx_err, i_net1_rxd,
			// For some reason, this 125MHz clock isn't being
			// generated (??)
			//
			// i_clk_125mhz,
			i_net1_rx_clk,
			o_net1_tx_clk, o_net1_tx_ctl, o_net1_txd,
			net1rx_int, net1tx_int, net1_debug_clk, net1_debug);

`else	// NET1_ACCESS

	// In the case that there is no net1 peripheral responding on the wb bus
	assign	net1_stall = 0;
	assign	net1_data  = 0;
	assign	net1_ack   = (wb_stb) && (net1_sel);

	assign	net1tx_int = 1'b0;	// net1.INT.NETTX.WIRE
	assign	net1rx_int = 1'b0;	// net1.INT.NETRX.WIRE
`endif	// NET1_ACCESS

`ifdef	NETCTRL1_ACCESS
	wire[31:0]	mdio1_debug;
	enetctrl #(.CLKBITS(2), .PHYADDR(5'h00))
		mdio1i(i_clk, i_reset, wb_cyc, (wb_stb)&&(mdio1_sel), wb_we,
				wb_addr[4:0], wb_data[15:0],
			mdio1_ack, mdio1_stall, mdio1_data,
			o_net1_mdc, o_mdio1, i_mdio1, o_mdio1_we, mdio1_debug);
`else	// NETCTRL1_ACCESS
	assign	o_net1_mdc = 1'b1;
	assign	o_mdio1  = 1'b1;
	assign	o_mdio1_we  = 1'b0;

	// In the case that there is no mdio1 peripheral responding on the wb bus
	assign	mdio1_stall = 0;
	assign	mdio1_data  = 0;
	assign	mdio1_ack   = (wb_stb) && (mdio1_sel);

`endif	// NETCTRL1_ACCESS

`ifdef	BKRAM_ACCESS
	memdev #(.LGMEMSZ(16), .EXTRACLOCK(1))
		bkrami(i_clk, i_reset,
			(wb_cyc), (wb_stb)&&(bkram_sel), wb_we,
				wb_addr[(16-3):0], wb_data, wb_sel,
				bkram_ack, bkram_stall, bkram_data);
`else	// BKRAM_ACCESS

	// In the case that there is no bkram peripheral responding on the wb bus
	assign	bkram_stall = 0;
	assign	bkram_data  = 0;
	assign	bkram_ack   = (wb_stb) && (bkram_sel);

`endif	// BKRAM_ACCESS

`ifdef	BUSCONSOLE_ACCESS
	wbconsole #(.LGFLEN(6)) console(i_clk, 1'b0,
 			wb_cyc, (wb_stb)&&(uart_sel), wb_we,
				wb_addr[1:0], wb_data,
 			uart_ack, uart_stall, uart_data,
			w_console_tx_stb, w_console_tx_data, w_console_busy,
			w_console_rx_stb, w_console_rx_data,
			uartrx_int, uarttx_int, uartrxf_int, uarttxf_int);
`else	// BUSCONSOLE_ACCESS

	// In the case that there is no uart peripheral responding on the wb bus
	assign	uart_stall = 0;
	assign	uart_data  = 0;
	assign	uart_ack   = (wb_stb) && (uart_sel);

	assign	uarttxf_int = 1'b0;	// uart.INT.UARTTXF.WIRE
	assign	uartrxf_int = 1'b0;	// uart.INT.UARTRXF.WIRE
	assign	uarttx_int = 1'b0;	// uart.INT.UARTTX.WIRE
	assign	uartrx_int = 1'b0;	// uart.INT.UARTRX.WIRE
`endif	// BUSCONSOLE_ACCESS

`ifdef	FLASH_ACCESS
	qflexpress #(.LGFLASHSZ(24), .OPT_CLKDIV(1),
		.NDUMMY(2), .RDDELAY(0),
		.OPT_STARTUP_FILE("micron.hex"),
`ifdef	FLASHCFG_ACCESS
		.OPT_CFG(1'b1)
`else
		.OPT_CFG(1'b0)
`endif
		)
		flashi(i_clk, i_reset,
			(wb_cyc), (wb_stb)&&(flash_sel),
			(wb_stb)&&(flashcfg_sel), wb_we,
			wb_addr[(24-3):0], wb_data,
			flash_ack, flash_stall, flash_data,
			o_qspi_sck, o_qspi_cs_n, o_qspi_mod, o_qspi_dat, i_qspi_dat,
			flash_dbg_trigger, flash_debug);
`else	// FLASH_ACCESS
	assign	o_qspi_sck  = 1'b1;
	assign	o_qspi_cs_n = 1'b1;
	assign	o_qspi_mod  = 2'b01;
	assign	o_qspi_dat  = 4'b1111;

	// In the case that there is no flash peripheral responding on the wb bus
	assign	flash_stall = 0;
	assign	flash_data  = 0;
	assign	flash_ack   = (wb_stb) && (flash_sel);

`endif	// FLASH_ACCESS

	assign	buildtime_data = `BUILDTIME;
	assign	buildtime_ack = wb_stb && buildtime_sel;
	assign	buildtime_stall = 1'b0;
`ifdef	SPIO_ACCESS
	//
	// Special purpose I/O driver (buttons, LEDs, and switches)
	//

	spio #(.NBTN(1), .NLEDS(8), .NSW(8)) spioi(i_clk,
		wb_cyc, (wb_stb)&&(spio_sel), wb_we, wb_data, wb_sel,
			spio_ack, spio_stall, spio_data,
		i_sw, i_btn, w_led, spio_int);

	assign	o_led = w_led;

`else	// SPIO_ACCESS
	assign	w_btn = 0;
	assign	o_led = 0;

	// In the case that there is no spio peripheral responding on the wb bus
	assign	spio_stall = 0;
	assign	spio_data  = 0;
	assign	spio_ack   = (wb_stb) && (spio_sel);

	assign	spio_int = 1'b0;	// spio.INT.SPIO.WIRE
`endif	// SPIO_ACCESS

`ifdef	NETSCOPE_SCOPE
   	wbscope #(.LGMEM(9),
		.SYNCHRONOUS(0))
	enetscopei(net1_debug_clk, 1'b1, net1_dbg_trigger, net1_debug,
		i_clk, wb_cyc, (wb_stb)&&(enetscope_sel), wb_we,
		wb_addr[0], wb_data, enetscope_ack, enetscope_stall,
		enetscope_data, enetscope_int);


	assign	net1_dbg_trigger = net1_debug[31];
`else	// NETSCOPE_SCOPE
	assign	enetscope_int = 0;

	// In the case that there is no enetscope peripheral responding on the wb bus
	assign	enetscope_stall = 0;
	assign	enetscope_data  = 0;
	assign	enetscope_ack   = (wb_stb) && (enetscope_sel);

	assign	enetscope_int = 1'b0;	// enetscope.INT.ENETSCOPE.WIRE
`endif	// NETSCOPE_SCOPE

`ifdef	BUSPIC_ACCESS
	//
	// The BUS Interrupt controller
	//
	icontrol #(15)	buspici(i_clk, 1'b0,
			(wb_stb)&&(buspic_sel), wb_we, wb_data,
			buspic_ack, buspic_stall, buspic_data,
			bus_int_vector, w_bus_int);
`else	// BUSPIC_ACCESS

	// In the case that there is no buspic peripheral responding on the wb bus
	assign	buspic_stall = 0;
	assign	buspic_data  = 0;
	assign	buspic_ack   = (wb_stb) && (buspic_sel);

`endif	// BUSPIC_ACCESS

`ifdef	PWRCOUNT_ACCESS
	initial	r_pwrcount_data = 32'h0;
	always @(posedge i_clk)
	if (r_pwrcount_data[31])
		r_pwrcount_data[30:0] <= r_pwrcount_data[30:0] + 1'b1;
	else
		r_pwrcount_data[31:0] <= r_pwrcount_data[31:0] + 1'b1;
	assign	pwrcount_data = r_pwrcount_data;
`else	// PWRCOUNT_ACCESS

	// In the case that there is no pwrcount peripheral responding on the wb bus
	assign	pwrcount_stall = 0;
	assign	pwrcount_data  = 0;
	assign	pwrcount_ack   = (wb_stb) && (pwrcount_sel);

`endif	// PWRCOUNT_ACCESS

	assign	i_net_tx_clk = i_clk_125mhz;
	always @(posedge i_clk)
		if (wb_err)
			r_buserr_addr <= wb_addr;
	assign	buserr_data = { {(32-2-23){1'b0}},
			r_buserr_addr, 2'b00 };
`ifdef	WBUBUS_MASTER
	localparam	DBGBUSBITS = $clog2(BUSUART);
	// The Host USB interface, to be used by the WB-UART bus
	rxuartlite	#(.TIMER_BITS(DBGBUSBITS),
				.CLOCKS_PER_BAUD(BUSUART[DBGBUSBITS-1:0]))
		rcv(i_clk, i_wbu_uart_rx,
				wbu_rx_stb, wbu_rx_data);
	txuartlite	#(.TIMING_BITS(DBGBUSBITS[4:0]),
				.CLOCKS_PER_BAUD(BUSUART[DBGBUSBITS-1:0]))
		txv(i_clk,
				wbu_tx_stb,
				wbu_tx_data,
				o_wbu_uart_tx,
				wbu_tx_busy);

`ifdef	INCLUDE_ZIPCPU
`else
	assign	zip_dbg_ack   = 1'b0;
	assign	zip_dbg_stall = 1'b0;
	assign	zip_dbg_data  = 0;
`endif
`ifndef	BUSPIC_ACCESS
	wire	w_bus_int;
	assign	w_bus_int = 1'b0;
`endif
	wire	[31:0]	wbu_tmp_addr;
	wbuconsole genbus(i_clk, wbu_rx_stb, wbu_rx_data,
			wbu_cyc, wbu_stb, wbu_we, wbu_tmp_addr, wbu_data,
			wbu_ack, wbu_stall, wbu_err, wbu_idata,
			w_bus_int,
			wbu_tx_stb, wbu_tx_data, wbu_tx_busy,
			//
			w_console_tx_stb, w_console_tx_data, w_console_busy,
			w_console_rx_stb, w_console_rx_data,
			//
			wbubus_dbg[0]);
	assign	wbu_sel = 4'hf;
	assign	wbu_addr = wbu_tmp_addr[(23-1):0];
`else	// WBUBUS_MASTER

	// In the case that nothing drives the wbu bus ...
	assign	wbu_cyc = 1'b0;
	assign	wbu_stb = 1'b0;
	assign	wbu_we  = 1'b0;
	assign	wbu_sel = 0;
	assign	wbu_addr= 0;
	assign	wbu_data= 0;
	// verilator lint_off UNUSED
	wire	unused_bus_wbu;
	assign	unused_bus_wbu = &{ 1'b0, wbu_ack, wbu_stall, wbu_err, wbu_data };
	// verilator lint_on  UNUSED

`endif	// WBUBUS_MASTER

`ifdef	GPIO_ACCESS
	//
	// GPIO
	//
	// This interface should allow us to control up to 16 GPIO inputs, and
	// another 16 GPIO outputs.  The interrupt trips when any of the inputs
	// changes.  (Sorry, which input isn't (yet) selectable.)
	//
	localparam	INITIAL_GPIO = 3'h3;
	wbgpio	#(NGPI, NGPO, INITIAL_GPIO)
		gpioi(i_clk, 1'b1, (wb_stb)&&(gpio_sel), wb_we,
			wb_data, gpio_data, i_gpio, o_gpio,
			gpio_int);
`else	// GPIO_ACCESS

	// In the case that there is no gpio peripheral responding on the wb bus
	assign	gpio_stall = 0;
	assign	gpio_data  = 0;
	assign	gpio_ack   = (wb_stb) && (gpio_sel);

	assign	gpio_int = 1'b0;	// gpio.INT.GPIO.WIRE
`endif	// GPIO_ACCESS

`ifdef	INCLUDE_CPU
	//
	//
	// And an arbiter to decide who gets access to the bus
	//
	//
	// Clock speed = 50000000 Hz
	wbpriarbiter #(32,23)	bus_arbiter(i_clk,
		// The Zip CPU bus master --- gets the priority slot
		cpu_cyc, (cpu_stb)&&(cpu_delay_sel), cpu_we, cpu_addr, cpu_data, cpu_sel,
			cpu_delay_ack, cpu_delay_stall, cpu_delay_err,
		// The UART interface master
		(wbu_cyc),
			(wbu_stb)&&(wbu_delay_sel),
			wbu_we,
			wbu_addr[(23-1):0],
			wbu_data, wbu_sel,
			wbu_delay_ack, wbu_delay_stall, wbu_delay_err,
		// Common bus returns
		wbu_delayi_cyc, wbu_delayi_stb, wbu_delayi_we, wbu_delayi_addr, wbu_delayi_odata, wbu_delayi_sel,
			wbu_delayi_ack, wbu_delayi_stall, wbu_delayi_err);

	// And because the ZipCPU and the Arbiter can create an unacceptable
	// delay, we often fail timing.  So, we add in a delay cycle
`else
	// If no ZipCPU, no delay arbiter is needed
	assign	wbu_delayi_cyc   = wbu_cyc;
	assign	wbu_delayi_stb   = wbu_stb;
	assign	wbu_delayi_we    = wbu_we;
	assign	wbu_delayi_addr  = wbu_addr;
	assign	wbu_delayi_odata = wbu_data;
	assign	wbu_delayi_sel   = wbu_sel;
	assign	wbu_delay_ack    = wbu_delayi_ack;
	assign	wbu_delay_stall  = wbu_delayi_stall;
	assign	wbu_delay_err    = wbu_delayi_err;
	assign	wbu_delay_data   = wbu_delayi_idata;
`endif	// INCLUDE_CPU

`ifdef	WBUBUS_MASTER
`ifdef	INCLUDE_CPU
`define	BUS_DELAY_NEEDED
`endif
`endif
`ifdef	BUS_DELAY_NEEDED
	busdelay #(23)	wbu_delayi_delay(i_clk, i_reset,
		wbu_delayi_cyc, wbu_delayi_stb, wbu_delayi_we, wbu_delayi_addr, wbu_delayi_odata, wbu_delayi_sel,
			wbu_delayi_ack, wbu_delayi_stall, wbu_delayi_idata, wbu_delayi_err,
		wb_cyc, wb_stb, wb_we, wb_addr, wb_data, wb_sel,
			wb_ack, wb_stall, wb_idata, wb_err);
`else
	// If one of the two, the ZipCPU or the WBUBUS, isn't here, then we
	// don't need the bus delay, and we can go directly from the bus driver
	// to the bus itself
	//
	assign	wb_cyc    = wbu_delayi_cyc;
	assign	wb_stb    = wbu_delayi_stb;
	assign	wb_we     = wbu_delayi_we;
	assign	wb_addr   = wbu_delayi_addr;
	assign	wb_data   = wbu_delayi_odata;
	assign	wb_sel    = wbu_delayi_sel;
	assign	wbu_delayi_ack   = wb_ack;
	assign	wbu_delayi_stall = wb_stall;
	assign	wbu_delayi_err   = wb_err;
	assign	wbu_delayi_idata = wb_idata;
`endif
	assign	wbu_delay_data = wbu_delayi_idata;
`ifdef	INCLUDE_CPU
	assign	cpu_delay_data = wbu_delayi_idata;
`endif
`ifdef	FLASHCFG_ACCESS
	// The Flash control interface result comes back together with the
	// flash interface itself.  Hence, we always return zero here.
	assign	flashcfg_ack   = 1'b0;
	assign	flashcfg_stall = 1'b0;
	assign	flashcfg_data  = flash_data;
`else	// FLASHCFG_ACCESS

	// In the case that there is no flashcfg peripheral responding on the wb bus
	assign	flashcfg_stall = 0;
	assign	flashcfg_data  = 0;
	assign	flashcfg_ack   = (wb_stb) && (flashcfg_sel);

`endif	// FLASHCFG_ACCESS

	assign	version_data = `DATESTAMP;
	assign	version_ack = wb_stb && version_sel;
	assign	version_stall = 1'b0;
`ifdef	INCLUDE_PICORV
	wb_picorv32 #(.PROGADDR_RESET(10485760),
			.STACKADDR(10551296))
		picorvi(picorv_trap,
			i_clk, i_reset,
			cpu_cyc, cpu_stb, cpu_we,
				cpu_addr_wide, cpu_data, cpu_sel,
			cpu_stall, cpu_ack, cpu_data,
			cpu_err,
			picorv_int_vec);

	assign	cpu_addr = cpu_addr_wide[23-1:0];
`else	// INCLUDE_PICORV

	// In the case that nothing drives the cpu bus ...
	assign	cpu_cyc = 1'b0;
	assign	cpu_stb = 1'b0;
	assign	cpu_we  = 1'b0;
	assign	cpu_sel = 0;
	assign	cpu_addr= 0;
	assign	cpu_data= 0;
	// verilator lint_off UNUSED
	wire	unused_bus_cpu;
	assign	unused_bus_cpu = &{ 1'b0, cpu_ack, cpu_stall, cpu_err, cpu_data };
	// verilator lint_on  UNUSED

`endif	// INCLUDE_PICORV

`ifdef	WBFFT_ACCESS
	wbfft fft(i_clk, i_reset, wb_cyc, (wb_stb)&&(wbfft_sel), wb_we,
			wb_addr[10:0], wb_data, wbfft_stall,
			wbfft_ack, wbfft_data, wbfft_int);
`else	// WBFFT_ACCESS

	// In the case that there is no wbfft peripheral responding on the wb bus
	assign	wbfft_stall = 0;
	assign	wbfft_data  = 0;
	assign	wbfft_ack   = (wb_stb) && (wbfft_sel);

`endif	// WBFFT_ACCESS



endmodule // main.v
