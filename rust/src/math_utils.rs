/// Numeric helper functions.

/// Constrain a value within [lo, hi].
pub fn clamp<T: PartialOrd>(val: T, lo: T, hi: T) -> T {
    if val < lo {
        lo
    } else if val > hi {
        hi
    } else {
        val
    }
}

/// Compute the greatest common divisor (Euclid).
pub fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

/// Check whether an integer is even.
pub fn is_even(n: i32) -> bool {
    n & 1 == 0
}

/// Exponentiate by squaring (non-negative exponent only).
pub fn pow(base: i64, exp: u32) -> i64 {
    match exp {
        0 => 1,
        _ => {
            let mut result = 1i64;
            let mut b = base;
            let mut e = exp;
            while e > 0 {
                if e & 1 == 1 {
                    result *= b;
                }
                b *= b;
                e >>= 1;
            }
            result
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_clamp_in_range() {
        assert_eq!(clamp(5, 0, 10), 5);
    }

    #[test]
    fn test_clamp_below() {
        assert_eq!(clamp(-1, 0, 10), 0);
    }

    #[test]
    fn test_clamp_above() {
        assert_eq!(clamp(15, 0, 10), 10);
    }

    #[test]
    fn test_gcd() {
        assert_eq!(gcd(12, 8), 4);
    }

    #[test]
    fn test_is_even() {
        assert!(is_even(4));
        assert!(!is_even(3));
    }

    #[test]
    fn test_pow() {
        assert_eq!(pow(2, 10), 1024);
    }
}
