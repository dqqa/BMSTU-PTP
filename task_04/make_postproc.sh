#!/bin/bash

# Скрипт для построения графиков

CUR_DIR=$(dirname "$(readlink -e "$0")")

echo "[INFO] plotting data"

gnuplot "$CUR_DIR"/moustache.gp -persist
gnuplot "$CUR_DIR"/avg.gp -persist
gnuplot "$CUR_DIR"/err.gp -persist

echo "[SUCCESS] done plotting. All plots are saved in output/ dir."
