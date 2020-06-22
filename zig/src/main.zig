const std = @import("std");
const pow = std.math.pow;

const N: u32 = 440_000_000;
const cache = getCache();

fn getCache() [10]u32 {
    var result: [10]u32 = undefined;

    result[0] = 0;
    var i: u32 = 1;
    while (i < 10) : (i += 1) {
        result[i] = pow(u32, i, i);
    }

    return result;
}

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
    const stdout = std.io.getStdOut().outStream();

    var n: u32 = 0;

    while (n < N) : (n += 1) {
        if (n > 0 and n % 1_000_000 == 0) {
            try stdout.print("# {}\n", .{n});
        }

        if (isMunchausen(n)) {
            try stdout.print("{}\n", .{n});
        }
    }
}
