title num stuff
@echo off
set /p file=File Name ( include .webm )= 

ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of default=nokey=1:noprint_wrappers=1 "%file%"

echo copy the number than this return and paste it in
echo in a file with the same name of your .webm video

pause