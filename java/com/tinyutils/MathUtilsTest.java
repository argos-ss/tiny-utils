package com.tinyutils;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class MathUtilsTest {

    // --- clamp ---

    @Test void clampInRange() {
        assertEquals(5.0, MathUtils.clamp(5.0, 0.0, 10.0), 0.001);
    }

    @Test void clampBelowLowerBound() {
        assertEquals(0.0, MathUtils.clamp(-1.0, 0.0, 10.0), 0.001);
    }

    @Test void clampAboveUpperBound() {
        assertEquals(10.0, MathUtils.clamp(15.0, 0.0, 10.0), 0.001);
    }

    @Test void clampEqualBounds() {
        assertEquals(5.0, MathUtils.clamp(5.0, 5.0, 5.0), 0.001);
    }

    // --- lerp ---

    @Test void lerpStart() {
        assertEquals(10.0, MathUtils.lerp(10.0, 20.0, 0.0), 0.001);
    }

    @Test void lerpEnd() {
        assertEquals(20.0, MathUtils.lerp(10.0, 20.0, 1.0), 0.001);
    }

    @Test void lerpMidpoint() {
        assertEquals(15.0, MathUtils.lerp(10.0, 20.0, 0.5), 0.001);
    }

    @Test void lerpClampLow() {
        assertEquals(10.0, MathUtils.lerp(10.0, 20.0, -0.5), 0.001);
    }

    @Test void lerpClampHigh() {
        assertEquals(20.0, MathUtils.lerp(10.0, 20.0, 1.5), 0.001);
    }

    // --- roundTo ---

    @Test void roundToDefault() {
        assertEquals(4.0, MathUtils.roundTo(3.7), 0.001);
    }

    @Test void roundToDecimals() {
        assertEquals(3.14, MathUtils.roundTo(3.14159, 2), 0.001);
    }

    @Test void roundToZero() {
        assertEquals(3.0, MathUtils.roundTo(3.0), 0.001);
    }

    // --- percentage ---

    @Test void percentageBasic() {
        assertEquals(25.0, MathUtils.percentage(25.0, 100.0), 0.01);
    }

    @Test void percentageTotalZero() {
        assertEquals(0.0, MathUtils.percentage(10.0, 0.0), 0.001);
    }

    @Test void percentageFractional() {
        assertEquals(33.33, MathUtils.percentage(1.0, 3.0), 0.01);
    }

    // --- average ---

    @Test void averageBasic() {
        assertEquals(3.0, MathUtils.average(1.0, 2.0, 3.0, 4.0, 5.0), 0.001);
    }

    @Test void averageEmpty() {
        assertEquals(0.0, MathUtils.average(), 0.001);
    }

    @Test void averageSingle() {
        assertEquals(42.0, MathUtils.average(42.0), 0.001);
    }

    @Test void averageNegative() {
        assertEquals(0.0, MathUtils.average(-5.0, 5.0), 0.001);
    }
}
