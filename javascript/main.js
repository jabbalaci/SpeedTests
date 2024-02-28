const CACHE = new Array(80)
for (let j = 0; j < CACHE.length; j += 10) {
    CACHE[j] = 0
    for (let i =  1; i < 10; i++) {
        CACHE[i + j] = i ** i
    }
}

loop: for (let i = 0; i < 440_000_000; i++) {
    let total = 0
    let n = i
    while (n > 0) {
        total += CACHE[n % 80];
        if (total > i) {
            continue loop
        }
        n = (n / 10) | 0;
    }
    if (total < i) continue loop
    console.log(i);
}