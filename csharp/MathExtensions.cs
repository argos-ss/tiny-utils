using System;

namespace TinyUtils
{
    /// <summary>
    /// Math transformation extension methods for numeric types.
    ///
    /// Pure static methods — no side effects, no mutation.
    /// </summary>
    public static class MathExtensions
    {
        /// <summary>
        /// Clamp a value between a lower and upper bound (inclusive).
        /// </summary>
        public static double Clamp(this double value, double low, double high) =>
            Math.Max(low, Math.Min(high, value));

        /// <summary>
        /// Linear interpolation between <paramref name="a"/> and <paramref name="b"/>
        /// by <paramref name="t"/> [0..1].
        /// </summary>
        public static double Lerp(this double a, double b, double t) =>
            a + (b - a) * t.Clamp(0.0, 1.0);

        /// <summary>
        /// Round a number to a specified number of decimal places.
        /// </summary>
        public static double RoundTo(this double value, int decimals)
        {
            double factor = Math.Pow(10, decimals);
            return Math.Round(value * factor) / factor;
        }

        /// <summary>
        /// Calculate the percentage that <paramref name="part"/> represents
        /// of <paramref name="total"/>.
        /// </summary>
        public static double PercentageOf(this double part, double total) =>
            total == 0.0 ? 0.0 : ((part / total) * 100).RoundTo(2);

        /// <summary>
        /// Return the arithmetic mean of a sequence of doubles.
        /// </summary>
        public static double Average(params double[] values)
        {
            if (values.Length == 0) return 0.0;
            double sum = 0.0;
            foreach (double v in values) sum += v;
            return sum / values.Length;
        }
    }
}
