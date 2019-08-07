////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./main_tb.cpp
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
//
// SIM.INCLUDE
//
// Any SIM.INCLUDE tags you define will be pasted here.
// This is useful for guaranteeing any include functions
// your simulation needs are called.
//
// Looking for string: SIM.INCLUDE
#include "verilated.h"
#include "Vmain.h"
#define	BASECLASS	Vmain

#include "design.h"
#include "regdefs.h"
#include "testb.h"
#include "enetctrlsim.h"
#include "byteswap.h"
#include "flashsim.h"
#include "dbluartsim.h"
#include "zipelf.h"

//
// SIM.DEFINES
//
// This tag is useful fr pasting in any #define values that
// might then control the simulation following.
//
// Looking for string: SIM.DEFINES
#ifndef VVAR
#ifdef  NEW_VERILATOR
#define VVAR(A) main__DOT_ ## A
#else
#define VVAR(A) v__DOT_ ## A
#endif
#endif

#define	block_ram	VVAR(_bkrami__DOT__mem)
class	MAINTB : public TESTB<Vmain> {
public:
		// SIM.DEFNS
		//
		// If you have any simulation components, create a
		// SIM.DEFNS tag to have those components defined here
		// as part of the main_tb.cpp function.
// Looking for string: SIM.DEFNS
#ifdef	NETCTRL1_ACCESS
	ENETCTRLSIM	*m_mdio1;
#endif // NETCTRL1_ACCESS
#ifdef	FLASH_ACCESS
	FLASHSIM	*m_flash;
#endif // FLASH_ACCESS
	DBLUARTSIM	*m_wbu;
	MAINTB(void) {
		// SIM.INIT
		//
		// If your simulation components need to be initialized,
		// create a SIM.INIT tag.  That tag's value will be pasted
		// here.
		//
		// From mdio1
#ifdef	NETCTRL1_ACCESS
		m_mdio1 = new ENETCTRLSIM;
#endif // NETCTRL1_ACCESS
		// From flash
#ifdef	FLASH_ACCESS
		m_flash = new FLASHSIM(FLASHLGLEN, false, 0, 2);
#endif // FLASH_ACCESS
		// From wbu
		m_wbu = new DBLUARTSIM();
		m_wbu->setup(50);
		// From picorv
	}

	void	reset(void) {
		// SIM.SETRESET
		// If your simulation component needs logic before the
		// tick with reset set, that logic can be placed into
		// the SIM.SETRESET tag and thus pasted here.
		//
// Looking for string: SIM.SETRESET
		TESTB<Vmain>::reset();
		// SIM.CLRRESET
		// If your simulation component needs logic following the
		// reset tick, that logic can be placed into the
		// SIM.CLRRESET tag and thus pasted here.
		//
// Looking for string: SIM.CLRRESET
	}

	void	trace(const char *vcd_trace_file_name) {
		fprintf(stderr, "Opening TRACE(%s)\n",
				vcd_trace_file_name);
		opentrace(vcd_trace_file_name);
		m_time_ps = 0;
	}

	void	close(void) {
		m_done = true;
	}

	void	tick(void) {
		if (done())
			return;
		TESTB<Vmain>::tick(); // Clock.size = 3
	}


	// Evaluating clock net1_rx_clk

	// sim_net1_rx_clk_tick() will be called from TESTB<Vmain>::tick()
	//   following any falling edge of clock net1_rx_clk
	virtual	void	sim_net1_rx_clk_tick(void) {
		// Default clock tick
		//
		// SIM.TICK tags go here for SIM.CLOCK=net1_rx_clk
		//
		// SIM.TICK from flash
#ifdef	FLASH_ACCESS
		m_core->i_qspi_dat = m_flash->simtick(
			m_core->o_qspi_cs_n,
			m_core->o_qspi_sck,
			m_core->o_qspi_dat,
			m_core->o_qspi_mod);
#endif // FLASH_ACCESS
		// SIM.TICK from picorv
	}

	// Evaluating clock clk

	// sim_clk_tick() will be called from TESTB<Vmain>::tick()
	//   following any falling edge of clock clk
	virtual	void	sim_clk_tick(void) {
		//
		// SIM.TICK tags go here for SIM.CLOCK=clk
		//
		// SIM.TICK from mdio1
#ifdef	NETCTRL1_ACCESS
		m_core->i_mdio1 = (*m_mdio1)(0, m_core->o_net1_mdc,
				((m_core->o_mdio1_we)&&(!m_core->o_mdio1))?0:1);
#else
		m_core->i_mdio1 = ((m_core->o_mdio1_we)&&(!m_core->o_mdio1))?0:1;
#endif // NETCTRL1_ACCESS
		// SIM.TICK from wbu
		m_core->i_wbu_uart_rx = (*m_wbu)(m_core->o_wbu_uart_tx);
	}

	// Evaluating clock clk_125mhz

	// sim_clk_125mhz_tick() will be called from TESTB<Vmain>::tick()
	//   following any falling edge of clock clk_125mhz
	virtual	void	sim_clk_125mhz_tick(void) {
		//
		// SIM.TICK tags go here for SIM.CLOCK=clk_125mhz
		//
		// SIM.TICK from net1
		m_core->i_net1_rx_dv  = m_core->o_net1_tx_ctl;
		m_core->i_net1_rx_err = 0;
		m_core->i_net1_rxd    = m_core->o_net1_txd;

	}
	//
	// Step until clock net1_rx_clk ticks
	//
	virtual	void	tick_net1_rx_clk(void) {
		// Advance until the default clock ticks
		do {
			tick();
		} while(!m_net1_rx_clk.rising_edge());
	}

	//
	// Step until clock clk ticks
	//
	virtual	void	tick_clk(void) {
		do {
			tick();
		} while(!m_clk.rising_edge());
	}

	//
	// Step until clock clk_125mhz ticks
	//
	virtual	void	tick_clk_125mhz(void) {
		do {
			tick();
		} while(!m_clk_125mhz.rising_edge());
	}

	//
	// The load function
	//
	// This function is required by designs that need the flash or memory
	// set prior to run time.  The test harness should be able to call
	// this function to load values into any (memory-type) location
	// on the bus.
	//
	bool	load(uint32_t addr, const char *buf, uint32_t len) {
		uint32_t	start, offset, wlen, base, adrln;

		//
		// Loading the bkram component
		//
		base  = 0x00a00000; // in octets
		adrln = 0x00010000;

		if ((addr >= base)&&(addr < base + adrln)) {
			// If the start access is in bkram
			start = (addr > base) ? (addr-base) : 0;
			offset = (start + base) - addr;
			wlen = (len-offset > adrln - start)
				? (adrln - start) : len - offset;
#ifdef	BKRAM_ACCESS
			// FROM bkram.SIM.LOAD
			start = start & (-4);
			wlen = (wlen+3)&(-4);

			// Need to byte swap data to get it into the memory
			char	*bswapd = new char[len+8];
			memcpy(bswapd, &buf[offset], wlen);
			byteswapbuf(len>>2, (uint32_t *)bswapd);
			memcpy(&m_core->block_ram[start], bswapd, wlen);
			delete	bswapd;
			// AUTOFPGA::Now clean up anything else
			// Was there more to write than we wrote?
			if (addr + len > base + adrln)
				return load(base + adrln, &buf[offset+wlen], len-wlen);
			return true;
#else	// BKRAM_ACCESS
			return false;
#endif	// BKRAM_ACCESS
		//
		// End of components with a SIM.LOAD tag, and a
		// non-zero number of addresses (NADDR)
		//
		}

		//
		// Loading the flash component
		//
		base  = 0x01000000; // in octets
		adrln = 0x01000000;

		if ((addr >= base)&&(addr < base + adrln)) {
			// If the start access is in flash
			start = (addr > base) ? (addr-base) : 0;
			offset = (start + base) - addr;
			wlen = (len-offset > adrln - start)
				? (adrln - start) : len - offset;
#ifdef	FLASH_ACCESS
			// FROM flash.SIM.LOAD
#ifdef	FLASH_ACCESS
			m_flash->load(start, &buf[offset], wlen);
#endif // FLASH_ACCESS
			// AUTOFPGA::Now clean up anything else
			// Was there more to write than we wrote?
			if (addr + len > base + adrln)
				return load(base + adrln, &buf[offset+wlen], len-wlen);
			return true;
#else	// FLASH_ACCESS
			return false;
#endif	// FLASH_ACCESS
		//
		// End of components with a SIM.LOAD tag, and a
		// non-zero number of addresses (NADDR)
		//
		}

		return false;
	}

	//
	// KYSIM.METHODS
	//
	// If your simulation code will need to call any of its own function
	// define this tag by those functions (or other sim code), and
	// it will be pasated here.
	//
// Looking for string: SIM.METHODS
#ifdef	INCLUDE_PICORV
	void	loadelf(const char *elfname) {
		ELFSECTION	**secpp, *secp;
		uint32_t	entry;

		elfread(elfname, entry, secpp);

		for(int s=0; secpp[s]->m_len; s++) {
			bool	successful_load;
			secp = secpp[s];

			successful_load = load(secp->m_start,
				secp->m_data, secp->m_len);

			if (!successful_load) {
				printf("Could not load section "
					"from %08x to %08x--no such address\n",
					secp->m_start,
					secp->m_start+secp->m_len);
			}
		} free(secpp);
	}
#endif // INCLUDE_PICORV

};
