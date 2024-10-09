#!/bin/bash

# Скрипт для сборки различных конфигураций программ для тестирования

SIZES="500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7200 7500 8000 8500 9000 9500 10000 10500"
SORTS="bubble_sort_1 bubble_sort_2 bubble_sort_3"
SOURCES="main_in.c main_out.c"

CUR_DIR=$(dirname "$(readlink -e "$0")")

# Функция для сборки одной программы
build_app() {
    if [ ! -d "$CUR_DIR"/apps ]; then
        mkdir "$CUR_DIR"/apps
    fi
    if [[ "$4" == 1 ]]; then
        gcc -DSORT="$1" -DSIZE="$2" -DTICKS="$4" "$CUR_DIR"/"$3".c -o "$CUR_DIR"/apps/"$3"/TICKS_"$1".size_"$2".exe -O0 -lm
    else
        gcc -DSORT="$1" -DSIZE="$2" -DTICKS="$4" "$CUR_DIR"/"$3".c -o "$CUR_DIR"/apps/"$3"/TIME_"$1".size_"$2".exe -O0 -lm
    fi
}

# Очистка всех предыдущих программ
echo "[INFO] removing old data/*.exe files"
rm -rf "$CUR_DIR"/apps/*

# Сборка программ с измерением времени в наносекундах
echo "[INFO] starting building apps"
for src in $SOURCES; do
    src_base=$(basename "$src" .c)
    if [ ! -d "$CUR_DIR"/apps/"$src_base" ]; then
        mkdir -p "$CUR_DIR"/apps/"$src_base"
    fi

    for size in $SIZES; do
        for sort in $SORTS; do
            echo "[INFO] building $src_base $sort $size"
            build_app "$sort" "$size" "$src_base" 0
        done
    done
done

# Сборка программ с измерением времени в тиках
for src in $SOURCES; do
    src_base=$(basename "$src" .c)
    if [ ! -d "$CUR_DIR"/apps/"$src_base" ]; then
        mkdir -p "$CUR_DIR"/apps/"$src_base"
    fi

    for size in $SIZES; do
        for sort in $SORTS; do
            echo "[INFO] building $src_base $sort $size with ticks"
            build_app "$sort" "$size" "$src_base" 1
        done
    done
done
echo "[SUCCESS] all apps were built"
