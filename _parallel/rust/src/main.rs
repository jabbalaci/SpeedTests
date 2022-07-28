use rayon::prelude::*;

const N: i32 = 440_000_000;

fn is_munchausen(number: i32, cache: &[i32; 10]) -> bool {
    let mut n = number;
    let mut total = 0;

    while n > 0 {
        let digit = n % 10;
        total += cache[digit as usize];
        if total > number {
            return false;
        }
        n = n / 10;
    }
    number == total
}

fn get_cache() -> [i32; 10] {
    let mut cache = [0; 10];
    for n in 1..=9 {
        cache[n] = i32::pow(n as i32, n as u32);
    }
    cache
}

fn main() {
    let cache = get_cache();

    (0..N)
        .into_par_iter()
        .filter(|&i| is_munchausen(i, &cache))
        .for_each(|i| println!("{}", i))
}
