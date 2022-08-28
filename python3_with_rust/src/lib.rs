use once_cell::sync::Lazy;
use pyo3::prelude::*;

static CACHE: Lazy<[i32; 10]> = Lazy::new(|| {
    let mut cache = [0; 10]; // init. with 0s
    // cache[0] == 0
    for n in 1..=9 {
        cache[n] = (n as i32).pow(n as u32);
    }
    // println!("# {:?}", cache);
    cache
});

#[pyfunction]
fn is_munchausen(number: i32) -> PyResult<bool> {
    let mut n = number;
    let mut total = 0;

    while n > 0 {
        let digit = n % 10;
        total += CACHE[digit as usize];
        if total > number {
            return Ok(false);
        }
        n /= 10;
    }

    Ok(number == total)
}

/// A Python module implemented in Rust.
#[pymodule]
fn python3_with_rust(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(is_munchausen, m)?)?;
    Ok(())
}
