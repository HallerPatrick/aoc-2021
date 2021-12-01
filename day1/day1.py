try:
    from itertools import pairwise
except ImportError:
    from itertools import tee

    def pairwise(iterable):
        "s -> (s0,s1), (s1,s2), (s2, s3), ..."
        a, b = tee(iterable)
        next(b, None)
        return zip(a, b)


from copy import copy


def part1():
    """Lets do it the obscure functional way"""
    print(
        list(
            map(
                lambda x: x[0] < x[1],
                pairwise(
                    map(lambda x: int(x.strip()), open("input.txt", "r").readlines())
                ),
            )
        ).count(True)
    )


def part2():

    with open("input2.txt", "r") as f:
        lines = [int(line.strip()) for line in f.readlines()]

    current_depth = 0
    no_increases = 0
    for i, line in enumerate(lines):

        if i + 2 >= len(lines):
            break

        sum_depth = line + lines[i + 1] + lines[i + 2]

        if not current_depth:
            current_depth = sum_depth
            continue

        if sum_depth > current_depth:
            no_increases += 1

        current_depth = sum_depth

    print(no_increases)


def part2_():
    """Well this didnt work out"""

    stream = map(lambda x: int(x.strip()), open("input2.txt", "r").readlines())
    stream2 = copy(stream)
    next(stream2)

    grouped = lambda x: zip(*[x] * 3)
    print(
        list(
            map(
                lambda x: x[0] < x[1],
                map(
                    lambda x: (sum(x[0]), sum(x[1])),
                    zip(grouped(stream), grouped(stream2)),
                ),
            )
        ).count(True)
    )


if __name__ == "__main__":
    part1()
    part2_()
