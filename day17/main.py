from collections import defaultdict


def parse_input():
    with open("input.txt") as f:
        line = f.readline().replace("target area: ", "")

    x = None
    y = None
    for x_or_y in line.split(","):
        coord, _range = x_or_y.split("=")
        l, r = _range.split("..")

        if coord == "x":
            x = (int(l), int(r))
        else:
            y = (int(l), int(r.strip()))

    assert x
    assert y
    return x, y


def trick_shot():
    x_range, y_range = parse_input()

    probe_s = (0, 0)

    y_diff = abs(y_range[0] - probe_s[1])

    possible_y = defaultdict(list)
    for init_y in range(y_range[0], y_diff):
        check = init_y
        y_loc = probe_s[1]
        steps = 0
        while y_loc >= y_range[0]:
            if y_range[0] <= y_loc <= y_range[1]:
                possible_y[steps].append(init_y)
            steps += 1
            y_loc += check
            check -= 1

    min_x = 0
    x_loc = 0
    while x_loc < x_range[0]:
        min_x += 1
        x_loc += min_x
    possible_x = defaultdict(list)
    for init_x in range(min_x, x_range[1] + 1):
        check = init_x
        x_loc = probe_s[0]
        steps = 0
        while steps <= max(possible_y.keys()):
            if x_range[0] <= x_loc <= x_range[1]:
                possible_x[steps].append(init_x)
            steps += 1
            x_loc += check
            check = max(check - 1, 0)

    # Create a set of all possible initial velocities based on initial y and x pairs based on
    # number of steps
    init_vel = set()
    for step in range(max(possible_y.keys()) + 1):
        if step in possible_x and step in possible_y:
            for init_x in possible_x[step]:
                for init_y in possible_y[step]:
                    init_vel.add((init_x, init_y))

    return len(init_vel)


def part1():
    _, y_range = parse_input()
    print(min(y_range) * (min(y_range) + 1) // 2)


if __name__ == "__main__":
    print(trick_shot())
