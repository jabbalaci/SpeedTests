<?php

const N = 440_000_000;

$cache = array_map(fn($i) => $i === 0 ? 0 : $i**$i, range(0, 9));

function isMunchausen(int $number, array $cache): bool
{
    $n = $number;
    $total = 0;

    while ($n > 0) {
        $digit = $n % 10;
        $total += $cache[$digit];
        if ($total > $number) {
            return false;
        }
        $n = intdiv($n, 10);
    }

    return $total === $number;
}

for ($i = 0; $i < N; $i++) {
    if (isMunchausen($i, $cache)) {
        echo "$i\n";
    }
}