from copy import deepcopy as copy
from itertools import chain

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
        return packet_version

    # Operator packet
    length_type_id = next(iterator)
    print(f"Length type id: {length_type_id}")

    if length_type_id == "0":
        subpackage_length = int("".join(next_n(iterator, 15)), 2)
        print("Subpacket length: {}".format(subpackage_length))

        print(len(list(copy(iterator))))
        subpacket = iter(next_n(iterator, subpackage_length))

        while True:
            if list(copy(subpacket)):
                packet_version += read_packet(subpacket)
            else:
                break

    else:
        num_subpackets = int("".join(next_n(iterator, 11)), 2)
        for _ in range(num_subpackets):
            packet_version += read_packet(iterator)

    return packet_version


bin_strings = read_input()

print(read_packet(bin_strings))
print(list(bin_strings))
