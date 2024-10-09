#!/bin/bash

# Скрипт для запуска всех скриптов для компилляции и сбора данных

CUR_DIR=$(dirname "$(readlink -e "$0")")

echo "[INFO] starting all scripts"

"$CUR_DIR"/build_apps.sh
"$CUR_DIR"/update_data.sh
python3 "$CUR_DIR"/make_preproc.py
"$CUR_DIR"/make_postproc.sh

echo "[SUCCESS] everything is done"
