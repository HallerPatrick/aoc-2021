from copy import deepcopy as copy
import math

with open("input2.txt") as f:
    line = f.readline()


def read_input():
    bin_strings = []
    for _hex in line:
        if _hex.strip():
            for b in format(int(_hex, 16), "04b"):
                bin_strings.append(b)

    # ( ["0"] * (4 - len(bin_strings)) ) + bin_strings
    print(bin_strings)
    return iter(bin_strings)


def next_n(iterator, n):

    res = []
    for _ in range(0, n):
        res.append(next(iterator))
    return res


def read_packet(iterator):

    packet_version = int("".join(next_n(iterator, 3)), 2)

    type_id = int("".join(next_n(iterator, 3)), 2)

    print(f"PACKET VERSION: {packet_version}")
    print(f"Type ID: {type_id}")

    # Literal Packet
    if type_id == 4:

        bits = []
        while True:

            group = next_n(iterator, 5)

            if group[0] == "0":
                bits.extend(group[1:])
                break
            else:
                bits.extend(group[1:])

        num = int("".join(bits), 2)
        print(f"Literal value: {num}")
        return num

    # Operator packet
    length_type_id = next(iterator)
    print(f"Length type id: {length_type_id}")

    packets = []
    if length_type_id == "0":
        subpackage_length = int("".join(next_n(iterator, 15)), 2)
        print("Subpacket length: {}".format(subpackage_length))

        print(len(list(copy(iterator))))
        subpacket = iter(next_n(iterator, subpackage_length))

        while True:
            if list(copy(subpacket)):
                packets.append(read_packet(subpacket))
            else:
                break

    else:
        num_subpackets = int("".join(next_n(iterator, 11)), 2)
        for _ in range(num_subpackets):
            packets.append(read_packet(iterator))

    return operator(int(type_id))(packets)


def operator(id):
    print(f"GOT ID {id}")
    if id == 0:
        return sum
    if id == 1:
        return math.prod
    if id == 2:
        return min
    if id == 3:
        return max
    if id == 4:
        return lambda _: exit(-1)
    if id == 5:
        return lambda x: int(x[0] > x[1])
    if id == 6:
        return lambda x: int(x[0] < x[1])
    if id == 7:
        return lambda x: int(x[0] == x[1])
    return lambda: exit(-1)


bin_strings = read_input()

print(read_packet(bin_strings))
print(list(bin_strings))
