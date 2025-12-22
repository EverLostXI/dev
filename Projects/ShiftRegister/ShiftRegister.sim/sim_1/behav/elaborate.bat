@echo off
set xv_path=E:\\vivado\\Vivado\\2016.1\\bin
call %xv_path%/xelab  -wto 04d559be1fba4cf6966170f2123b74df -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot SRGtest_behav xil_defaultlib.SRGtest -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
