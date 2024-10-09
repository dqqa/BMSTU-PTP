# Скрипт для обработки сырых данных

import glob
from os.path import dirname, exists, basename, abspath
import os
from statistics import median
from rse import calc_rse

# Функция для рассчета всех необходимых данных из набора сырых и записи в файл
def preprocess(dataset, out_fp):
    for size, data in sorted(dataset, key=lambda x: x[0]):
        data.sort()

        _min, _max = data[0], data[-1]
        avg = sum(data) / len(data)
        med = median(data)
        low_q = median(data[: len(data) // 2])
        high_q = median(data[len(data) // 2 :])
        rse = calc_rse(data)

        out_fp.write(f"{size} {_min} {low_q} {avg} {high_q} {_max} {med} {rse}\n")


def main():
    print("[INFO] preprocessing data")

    cur_dir = dirname(abspath(__file__))
    if not exists(f"{cur_dir}/preprocessed"):
        os.mkdir(f"{cur_dir}/preprocessed")

    for measure_type in glob.glob(f"{cur_dir}/data/*"):
        measure_base=basename(measure_type)
        for type_dir in glob.glob(f"{cur_dir}/data/{measure_base}/*"):
            _type = basename(type_dir)
            if not exists(f"{cur_dir}/preprocessed/{measure_base}/{_type}"):
                os.makedirs(f"{cur_dir}/preprocessed/{measure_base}/{_type}")

            for sort_dir in glob.glob(f"{type_dir}/*"):
                sort = basename(sort_dir)
                data = []
                for data_file in glob.glob(f"{sort_dir}/*.txt"):
                    size = basename(data_file).split(".")[0]
                    with open(data_file) as in_fp:
                        data.append((int(size), list(map(float, in_fp.readlines()))))
                        
                if "ticks" == _type:
                    prep_file = f"{cur_dir}/preprocessed/{measure_base}/{_type}/{sort}.txt"
                else:
                    prep_file = f"{cur_dir}/preprocessed/{measure_base}/{_type}/{sort}.txt"

                with open(prep_file, "w") as out_fp:
                    preprocess(data, out_fp)

    print("[SUCCESS] data was preprocessed. Result is in preprocessed/ dir.")


if __name__ == "__main__":
    main()
