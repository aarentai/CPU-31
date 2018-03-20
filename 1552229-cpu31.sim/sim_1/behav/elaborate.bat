@echo off
set xv_path=E:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 691c595231c44659bb5cef7ed93edb80 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L dist_mem_gen_v8_0_10 -L unisims_ver -L unimacro_ver -L secureip --snapshot cpu_test_behav xil_defaultlib.cpu_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
