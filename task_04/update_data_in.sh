#!/bin/bash

# Скрипт для сбора данных при внутреннем замере

CUR_DIR=$(dirname "$(readlink -e "$0")")

data_dir="$CUR_DIR"/data

# Сбор данных в наносекундах
echo "[INFO] running inner measures"
for app in "$CUR_DIR"/apps/main_in/TIME_*.exe; do
    app_name=$(basename "$app")
    sort=$(echo "$app_name" | grep -oP "(?<=TIME_).*(?=.size)")
    size=$(echo "$app_name" | grep -oP "(?<=.size_)\K.*(?=.exe)")
    
    # Если не существует директория, создаем ее
    if [ ! -d "$data_dir"/main_in/time/"$sort" ]; then
        echo "[INFO] creating dir $data_dir/main_in/time/$sort"
        mkdir -p "$data_dir"/main_in/time/"$sort"
    fi

    echo "[INFO] inner sort: $sort; size: $size"
    "$app" >> "$data_dir"/main_in/time/"$sort"/"$size".txt
done

# Сбор данных в тиках
for app in "$CUR_DIR"/apps/main_in/TICKS_*.exe; do
    app_name=$(basename "$app")
    sort=$(echo "$app_name" | grep -oP "(?<=TICKS_).*(?=.size)")
    size=$(echo "$app_name" | grep -oP "(?<=.size_)\K.*(?=.exe)")
    
    # Если не существует директория, создаем ее
    if [ ! -d "$data_dir"/main_in/ticks/"$sort" ]; then
        echo "[INFO] creating dir $data_dir/main_in/ticks/$sort"
        mkdir -p "$data_dir"/main_in/ticks/"$sort"
    fi

    echo "[INFO] inner sort: $sort; size: $size with ticks"
    "$app" >> "$data_dir"/main_in/ticks/"$sort"/"$size".txt
done
echo "[SUCCESS] inner measures are done"
