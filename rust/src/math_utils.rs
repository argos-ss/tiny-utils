pub fn clamp<T: PartialOrd>(val: T, min: T, max: T) -> T {
    if val < min { min }
    else if val > max { max }
    else { val }
}

pub fn is_even(n: i32) -> bool { n % 2 == 0 }

pub fn fibonacci(n: u32) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        _ => {
            let (mut a, mut b) = (0, 1);
            for _ in 2..=n {
                let c = a + b;
                a = b;
                b = c;
            }
            b
        }
    }
}
