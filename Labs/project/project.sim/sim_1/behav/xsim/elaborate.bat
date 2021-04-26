@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Mon Apr 26 20:56:35 +0200 2021
REM SW Build 3064766 on Wed Nov 18 09:12:45 MST 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab -wto b426a8de36b6462696cfd2967924eadb --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_controler_behav xil_defaultlib.tb_controler -log elaborate.log"
call xelab  -wto b426a8de36b6462696cfd2967924eadb --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_controler_behav xil_defaultlib.tb_controler -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
