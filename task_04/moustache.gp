#!/bin/gnuplot -persist
reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/moustache_in.svg'

plot 'preprocessed/main_in/time/bubble_sort_1.txt' using 1:3:2:6:5 with candlesticks whiskerbars,\
'preprocessed/main_in/time/bubble_sort_1.txt' using 1:4:4:4:4 with candlesticks lt -1,\
'preprocessed/main_in/time/bubble_sort_1.txt' using 1:4 with linespoints,\

reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/moustache_out.svg'

plot 'preprocessed/main_out/time/bubble_sort_1.txt' using 1:3:2:6:5 with candlesticks whiskerbars,\
'preprocessed/main_out/time/bubble_sort_1.txt' using 1:4:4:4:4 with candlesticks lt -1,\
'preprocessed/main_out/time/bubble_sort_1.txt' using 1:4 with linespoints,\
