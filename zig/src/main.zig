const std = @import("std");
const pow = std.math.pow;
const build_options = @import("build_options");

const N: u32 = 440_000_000;
const cache = init: {
    var result: [10]u32 = undefined;

    result[0] = 0;
    var i: u32 = 1;
    while (i < 10) : (i += 1) {
        result[i] = pow(u32, i, i);
    }

    break :init result;
};

fn isMunchausen(number: u32) bool {
    var n = number;
    var total: u32 = 0;

    while (n > 0) {
        const digit = n % 10;
        total += cache[digit];

        if (total > number) {
            return false;
        }

        n = n / 10;
    }

    return total == number;
}

pub fn main() anyerror!void {
    const output = if (build_options.bufferedIo)
        std.io.bufferedOutStream(std.io.getStdOut().outStream()).outStream()
    else
        std.io.getStdOut().outStream();

    var n: u32 = 0;

    while (n < N) : (n += 1) {
        if (n > 0 and n % 1_000_000 == 0) {
            try output.print("# {}\n", .{n});
        }

        if (isMunchausen(n)) {
            try output.print("{}\n", .{n});
        }
    }
}
