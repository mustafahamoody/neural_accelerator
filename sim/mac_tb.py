# Mac unit TB

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ReadOnly, NextTimeStep

@cocotb.test()
async def test_mac(dut):
    # Start clock (10ns period)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Initialize all control pins to 0 (prevent undefined 'X' state)
    dut.en.value = 0
    dut.rst.value = 0
    dut.clr.value = 0
    dut.w.value = 0
    dut.x.value = 0
    
    # reset (prevent undefined 'X' state in out)
    dut.rst.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk) # Add second edge for power on reset (So sim dosen't read inital x to 1 when clk starts as an edge and set reset to 1 and back to 0 before mux takes value)
    await ReadOnly()            # jump to end of timestep — everything settled
    assert int(dut.out.value) == 0, f"Initializing Test Failed! Output: {int(dut.out.value)}, Expected: 0"
    await NextTimeStep()
    dut.rst.value = 0

    # Test input w/o en
    dut.clr.value = 1
    test_w = 5
    test_x = 5
    dut.w.value = test_w
    dut.x.value = test_x
    await RisingEdge(dut.clk)
    await ReadOnly()
    assert int(dut.out.value) == 0, f"ENABLE FAILED! Output : {dut.out.value}, Expected: 0"
    await NextTimeStep()


    # Test clear
    dut.en.value = 1
    dut.clr.value = 1
    test_w = 5
    test_x = 5
    expected = test_w * test_x
    dut.w.value = test_w
    dut.x.value = test_x
    await RisingEdge(dut.clk)
    await ReadOnly() 
    assert int(dut.out.value) == expected, f"Clear Failed! Output : {dut.out.value}, Expected: {expected}"  

    # Test Accumulate
    await NextTimeStep()
    dut.clr.value = 0
    test_w = 3
    test_x = 2
    expected += test_w*test_x
    dut.w.value = test_w
    dut.x.value = test_x
    await RisingEdge(dut.clk)
    await ReadOnly() 
    assert int(dut.out.value) == expected, f"Accumulate Failed! Output : {dut.out.value}, Expected: {expected}"

    # Test reset
    await NextTimeStep()
    dut.rst.value = 1
    await RisingEdge(dut.clk)
    await ReadOnly() 
    assert int(dut.out.value) == 0, f"Reset Test Failed! Output: {dut.out.value}, Expected: 0"
    await NextTimeStep()
    dut.rst.value = 0

    dut._log.info("MAC UNIT VERIFIED SUCCESSFULLY! (5/5 Test Passed)")