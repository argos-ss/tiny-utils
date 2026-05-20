import Foundation

// MARK: - Math Utilities

/// Clamp a value between a lower and upper bound (inclusive).
public func clamp<T: Comparable>(_ value: T, low: T, high: T) -> T {
    return max(low, min(high, value))
}

/// Linear interpolation between `a` and `b` by `t` [0..1].
public func lerp(_ a: Double, _ b: Double, _ t: Double) -> Double {
    return a + (b - a) * clamp(t, low: 0, high: 1)
}

/// Round a number to a specified number of decimal places.
public func roundTo(_ value: Double, _ decimals: Int = 0) -> Double {
    let factor = pow(10.0, Double(decimals))
    return (value * factor).rounded() / factor
}

/// Calculate the percentage that `part` represents of `total`.
public func percentage(_ part: Double, of total: Double) -> Double {
    guard total != 0 else { return 0 }
    return roundTo((part / total) * 100, 2)
}

/// Return the arithmetic mean of an array of numbers.
public func average(_ values: [Double]) -> Double {
    guard !values.isEmpty else { return 0 }
    return values.reduce(0, +) / Double(values.count)
}

// MARK: - MathUtils struct (namespace)

public struct MathUtils {
    public static func clamp<T: Comparable>(_ value: T, low: T, high: T) -> T {
        return max(low, min(high, value))
    }

    public static func lerp(_ a: Double, _ b: Double, _ t: Double) -> Double {
        return a + (b - a) * clamp(t, low: 0, high: 1)
    }

    public static func roundTo(_ value: Double, _ decimals: Int = 0) -> Double {
        let factor = pow(10.0, Double(decimals))
        return (value * factor).rounded() / factor
    }

    public static func percentage(_ part: Double, of total: Double) -> Double {
        guard total != 0 else { return 0 }
        return roundTo((part / total) * 100, 2)
    }

    public static func average(_ values: [Double]) -> Double {
        guard !values.isEmpty else { return 0 }
        return values.reduce(0, +) / Double(values.count)
    }
}
