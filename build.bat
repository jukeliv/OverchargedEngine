title Build Select
@echo off
echo //1. Release 64//
echo //2. Release 32//
echo //3. Debug//

set /p type=Buil Type= 

if "%type%"== "1" goto rel
if "%type%"== "2" goto 32
if "%type%"== "3" goto deb

:32
cls
title 32-Bits Build
lime build windows -32bit
pause
exit

:rel
cls
title Normal Build
lime build windows -minify
pause
exit

:deb
cls	
title Debug Build
lime build windows -debug
pause
exit
