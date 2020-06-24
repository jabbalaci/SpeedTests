use std::io::Write;
const MAX: i32 = 440_000_000;

fn is_munchausen(number: i32, cache: &[i32]) -> bool {
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

fn get_cache() -> Vec<i32> {
    (0..10).map(|n: i32| n.pow(n as u32)).collect()
}

fn main() {
    let cache = get_cache();

    let stream = std::io::stdout();
    let mut lock = stream.lock();

    for n in 0..MAX + 1 {
        if is_munchausen(n, &cache) {
            let _ = lock.write_fmt(format_args!("{}\n", n));
        }
    }
}
