#!/bin/bash

CUR_DIR=$(dirname "$(readlink -e "$0")")

echo "[INFO] cleaning all data, *.exe, cache"
rm -rf "$CUR_DIR"/data/* "$CUR_DIR"/apps/* "$CUR_DIR"/preprocessed/* "$CUR_DIR"/output/* "$CUR_DIR"/__pycache__/
