title Build
@echo off
echo //1. Release 64//
echo //2. Release 32//
echo 3. Debug//

set /p type=Buil Type= 

if "%type%"== "1" goto rel
if "%type%"== "2" goto 32
if "%type%"== "3" goto deb

:32
cls
lime build windows -32bit

:rel
cls
lime build windows -minify

:deb
cls	
lime build windows -debug
