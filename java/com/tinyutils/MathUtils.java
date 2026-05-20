package com.tinyutils;

/**
 * Math transformation utilities for Java.
 *
 * Pure static methods — no side effects, no state.
 * All methods return new values; inputs are never mutated.
 */
public final class MathUtils {

    private MathUtils() {
        // Utility class — prevent instantiation.
    }

    /**
     * Clamp a value between a lower and upper bound (inclusive).
     *
     * @param value The input value.
     * @param low   Lower bound.
     * @param high  Upper bound.
     * @return Clamped value within [low, high].
     */
    public static double clamp(double value, double low, double high) {
        return Math.max(low, Math.min(high, value));
    }

    /**
     * Linear interpolation between {@code a} and {@code b} by {@code t} [0..1].
     */
    public static double lerp(double a, double b, double t) {
        return a + (b - a) * clamp(t, 0.0, 1.0);
    }

    /**
     * Round a number to a specified number of decimal places.
     */
    public static double roundTo(double value, int decimals) {
        double factor = Math.pow(10, decimals);
        return Math.round(value * factor) / factor;
    }

    /**
     * Convenience — round to zero decimal places.
     */
    public static double roundTo(double value) {
        return roundTo(value, 0);
    }

    /**
     * Calculate the percentage that {@code part} represents of {@code total}.
     */
    public static double percentage(double part, double total) {
        if (total == 0.0) return 0.0;
        return roundTo((part / total) * 100, 2);
    }

    /**
     * Return the arithmetic mean of an array of doubles.
     */
    public static double average(double... values) {
        if (values.length == 0) return 0.0;
        double sum = 0.0;
        for (double v : values) {
            sum += v;
        }
        return sum / values.length;
    }
}
