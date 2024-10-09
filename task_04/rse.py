import sys


def calc_rse(dataset):
    if len(dataset) < 2:
        return

    avg = sum(dataset) / len(dataset)
    disp = sum([(el - avg) ** 2 for el in dataset]) / (len(dataset) - 1)
    disp = disp**0.5
    std_err = disp / (len(dataset) ** 0.5)

    return std_err / avg * 100


def main():
    if len(sys.argv) != 2:
        print("Incorrect number of arguments")
        print(f"Usage: {sys.argv[0]} {{file}}")
        exit(1)

    rse = -1
    with open(sys.argv[1]) as fp:
        data = list(map(float, fp.readlines()))
        rse = calc_rse(data)

    if not rse or rse > 1:
        # print(f"rse: {rse}")
        exit(1)


if __name__ == "__main__":
    main()
