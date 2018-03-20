@echo off
set xv_path=E:\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 691c595231c44659bb5cef7ed93edb80 -m64 --debug typical --relax --mt 2 --maxdelay -L xil_defaultlib -L simprims_ver -L secureip --snapshot cpu_test_time_impl -transport_int_delays -pulse_r 0 -pulse_int_r 0 xil_defaultlib.cpu_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
