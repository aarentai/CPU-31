@echo off
set xv_path=E:\\Vivado\\2016.2\\bin
call %xv_path%/xsim cpu_test_behav -key {Behavioral:sim_1:Functional:cpu_test} -tclbatch cpu_test.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
