#!/bin/gnuplot -persist

# IN
reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/err_in.svg'

plot 'preprocessed/main_in/time/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_in/time/bubble_sort_1.txt' using 1:4:2:6 with yerrorbars,\
'preprocessed/main_in/time/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_in/time/bubble_sort_2.txt' using 1:4:2:6 with yerrorbars,\
'preprocessed/main_in/time/bubble_sort_3.txt' using 1:4 with linespoints,\
'preprocessed/main_in/time/bubble_sort_3.txt' using 1:4:2:6 with yerrorbars

# OUT
reset

set xlabel "size"
set ylabel "time, ns"

set grid

set terminal svg size 1920, 1080
set output 'output/err_out.svg'

plot 'preprocessed/main_out/time/bubble_sort_1.txt' using 1:4 with linespoints,\
'preprocessed/main_out/time/bubble_sort_1.txt' using 1:4:2:6 with yerrorbars,\
'preprocessed/main_out/time/bubble_sort_2.txt' using 1:4 with linespoints,\
'preprocessed/main_out/time/bubble_sort_2.txt' using 1:4:2:6 with yerrorbars,\
'preprocessed/main_out/time/bubble_sort_3.txt' using 1:4 with linespoints,\
'preprocessed/main_out/time/bubble_sort_3.txt' using 1:4:2:6 with yerrorbars
