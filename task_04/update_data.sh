#!/bin/bash

# Скрипт для запуска внутреннего и внешнего замеров

CUR_DIR=$(dirname "$(readlink -e "$0")")

"$CUR_DIR"/update_data_in.sh
"$CUR_DIR"/update_data_out.sh
