#!/bin/gnuplot -persist
reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/avg_in_time.svg'

plot 'preprocessed/main_in/time/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_in/time/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_in/time/bubble_sort_3.txt' using 1:4 with linespoints

reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/avg_out_time.svg'

plot 'preprocessed/main_out/time/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_out/time/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_out/time/bubble_sort_3.txt' using 1:4 with linespoints

reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/avg_out_ticks.svg'

plot 'preprocessed/main_out/ticks/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_out/ticks/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_out/ticks/bubble_sort_3.txt' using 1:4 with linespoints

reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/avg_in_ticks.svg'

plot 'preprocessed/main_in/ticks/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_in/ticks/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_in/ticks/bubble_sort_3.txt' using 1:4 with linespoints
