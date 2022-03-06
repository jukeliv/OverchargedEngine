@echo off
color 0a
title Game Build
echo -- SELECT YOUR OS --
echo 1-. WINDOWS
echo 2-. LINUX
echo 3-. MAC
set /p osOption=OS= 
if "%osOption%"== "1" goto windows
if "%osOption%"== "2" goto linux
if "%osOption%"== "3" goto mac
:windows
lime build windows -minify
:linux
lime build linux -minify
:mac
lime build mac -minify
pause>exit
