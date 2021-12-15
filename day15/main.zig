const std = @import("std");

const allocator = std.heap.page_allocator;
const INT_MAX = 4294967295;

fn charToDigit(c: u8) u32 {
    return switch (c) {
        '0'...'9' => c - '0',
        'A'...'Z' => c - 'A' + 10,
        'a'...'z' => c - 'a' + 10,
        else => 0,
    };
}

fn readFile() anyerror!std.ArrayList(std.ArrayList(u32)) {
    var file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());

    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;

    var lines = std.ArrayList(std.ArrayList(u32)).init(allocator);

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |l| {
        var line = std.ArrayList(u32).init(allocator);

        for (l) |character| {
            try line.append(charToDigit(character));
        }

        try lines.append(line);
    }

    return lines;
}

fn minDistance(dist: std.ArrayList(u32), sptSet: std.ArrayList(u32)) u32 {
    var min: u32 = INT_MAX;
    var min_index: u32 = undefined;

    var v: u32 = 0;

    while (v < dist.items.len) {
        if ((sptSet.items[v] == 0) and (dist.items[v] <= min)) {
            min = dist.items[v];
            min_index = v;
        }
        v = v + 1;
    }

    return min_index;
}

fn dijkstra(graph: std.ArrayList(std.ArrayList(u32)), src: u32) anyerror!void {
    var dist = std.ArrayList(u32).init(allocator);

    var sptSet = std.ArrayList(u32).init(allocator);

    var i: u32 = 0;

    while (i < graph.items.len) {
        try dist.append(INT_MAX);
        try sptSet.append(0);
        i = i + 1;
    }

    dist.items[0] = src;

    var count: u32 = 0;
    while (count < graph.items.len - 1) {
        var u = minDistance(dist, sptSet);

        sptSet.items[u] = 1;

        var v: u32 = 0;
        while (v < graph.items.len) {
            if (sptSet.items[v] == 0 and dist.items[u] != INT_MAX and dist.items[u] + graph.items[u].items[v] < dist.items[v]) {
                dist.items[v] = dist.items[u] + graph.items[u].items[v];
            }
            v = v + 1;
        }

        count = count + 1;
    }

    std.debug.print("{any}", .{dist.items});
}

pub fn main() anyerror!void {
    const lines = try readFile();
    defer lines.deinit();

    try dijkstra(lines, 1);
}
