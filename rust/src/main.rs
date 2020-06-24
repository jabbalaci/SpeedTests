use std::io::Write;

const MAX: u32 = 440_000_000;

fn is_munchausen(number: u32, cache: &[u32]) -> bool {
    let mut n = number;
    let mut total = 0;

    while n > 0 {
        let digit = n % 10;
        total += cache[digit as usize];
        if total > number {
            return false;
        }
        n /= 10;
    }
    number == total
}

fn get_cache() -> Vec<u32> {
    (0..10).map(|n: u32| n.pow(n)).collect()
}

fn main() {
    let cache = get_cache();

    let stream = std::io::stdout();
    let mut lock = stream.lock();

    for n in 0u32..MAX + 1 {
        if is_munchausen(n, &cache) {
            let _ = lock.write_fmt(format_args!("{}\n", n));
        }
    }
}
