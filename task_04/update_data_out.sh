#!/bin/bash

# Скрипт для сбора данных при внешнем замере

CUR_DIR=$(dirname "$(readlink -e "$0")")
MIN_REPEATS=50

data_dir="$CUR_DIR"/data

# Сбор данных в наносекундах
echo "[INFO] running outer measures"
for app in "$CUR_DIR"/apps/main_out/TIME_*.exe; do
    app_name=$(basename "$app")
    sort=$(echo "$app_name" | grep -oP "(?<=TIME_).*(?=.size)")
    size=$(echo "$app_name" | grep -oP "(?<=.size_)\K.*(?=.exe)")
    
    # Если не существует директория, создаем ее
    if [ ! -d "$data_dir"/main_out/time/"$sort" ]; then
        echo "[INFO] creating dir $data_dir/main_out/time/$sort"
        mkdir -p "$data_dir"/main_out/time/"$sort"
    fi

    echo "[INFO] outer sort: $sort; size: $size"
    "$app" >> "$data_dir"/main_out/time/"$sort"/"$size".txt
    cnt=0
    # Пока RSE > 1%, вычисленное внутри python-скрипта, продолжаем замеры
    while ! python3 rse.py "$data_dir/main_out/time/$sort/$size.txt" || [ "$cnt" -lt "$MIN_REPEATS" ]; do
        "$app" >> "$data_dir"/main_out/time/"$sort"/"$size".txt
        cnt=$((cnt+1))
    done
done

# Сбор данных в тиках
for app in "$CUR_DIR"/apps/main_out/TICKS*.exe; do
    app_name=$(basename "$app")
    sort=$(echo "$app_name" | grep -oP "(?<=TICKS_).*(?=.size)")
    size=$(echo "$app_name" | grep -oP "(?<=.size_)\K.*(?=.exe)")
    
    # Если не существует директория, создаем ее
    if [ ! -d "$data_dir"/main_out/ticks/"$sort" ]; then
        echo "[INFO] creating dir $data_dir/main_out/ticks/$sort"
        mkdir -p "$data_dir"/main_out/ticks/"$sort"
    fi

    echo "[INFO] outer sort: $sort; size: $size with ticks"
    "$app" >> "$data_dir"/main_out/ticks/"$sort"/"$size".txt
    cnt=0
    # Пока RSE > 1%, вычисленное внутри python-скрипта, продолжаем замеры
    while ! python3 rse.py "$data_dir/main_out/ticks/$sort/$size.txt" || [ "$cnt" -lt "$MIN_REPEATS" ]; do
        "$app" >> "$data_dir"/main_out/ticks/"$sort"/"$size".txt
        cnt=$((cnt+1))
    done
done
echo "[SUCCESS] outer measures are done"
