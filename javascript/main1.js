var CACHE = Array.from({ length: 10 }, function (_, i) { return i === 0 ? 0 : Math.pow(i, i); });

var isMunchausen = function (number) {
    var total = 0, digit = 0, n = number;
    while (n > 0) {
        digit = n % 10;
        total += CACHE[digit];
        if (total > number) {
            return false;
        }
        n = Math.floor(n / 10);
    }
    return total === number;
};

for (var i = 0; i < 440_000_000; i++) {
    if (isMunchausen(i)) {
        console.log(i);
    }
}
