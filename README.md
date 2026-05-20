# 🧰 Tiny Utils

**Single‑responsibility utility functions — 14 languages, zero duplication.**

| #  | Language     | Files                                                              |
|----|--------------|--------------------------------------------------------------------|
| 1  | 🐍 Python    | str_utils, file_utils, collection_utils, **validation_utils**     |
| 2  | 🟨 JavaScript | str-utils, array-utils, **object-utils**                          |
| 3  | 🔵 TypeScript | date-utils, type-utils, **string-utils**, **math-utils**          |
| 4  | ☕ Java       | StringUtils, **MathUtils**                                         |
| 5  | 🟣 Kotlin     | Collections, **Strings (extensions)**                              |
| 6  | 🍎 Swift      | StringUtils, **MathUtils**                                         |
| 7  | 💎 Ruby       | string_utils, **array_utils**                                      |
| 8  | #️⃣ C#         | StringExtensions, **MathExtensions**                               |
| 9  | 🐘 PHP        | Str, **Arr**                                                       |
| 10 | 🎯 Dart       | string_utils, math_utils, **date_utils**                           |
| 11 | 🔶 Rust       | str_utils, math_utils, **collection_utils** (+ tests)              |
| 12 | 🔷 Go         | strutil, mathutil, **sliceutil** (generics)                        |
| 13 | 🌙 Lua        | str, **math_utils**                                                |
| 14 | 🐚 Bash       | colors, file-ops, **string.sh**                                    |

## Design
- **Single Responsibility** — one function per task
- **Pure Functions** — no side effects, no state
- **Zero Duplication** — every pattern appears once
- **Clean Code** — documented, typed, testable

### New Additions (20 May 2026)
| Language     | File              | Contents                                              |
|--------------|-------------------|-------------------------------------------------------|
| Python       | validation_utils  | is_email, is_url, is_phone, is_not_blank, is_in_range |
| JavaScript   | object-utils      | deepClone, pick, omit, deepMerge, entries             |
| TypeScript   | string-utils      | slugify, truncate, camelToSnake, reverseWords, toPascal |
| TypeScript   | math-utils        | clamp, lerp, roundTo, percentage, average, median     |
| Java         | MathUtils         | clamp, lerp, roundTo, percentage, average              |
| Kotlin       | Strings           | slugify, truncate, camelToSnake, reverseWords, toPascal |
| Swift        | MathUtils         | clamp, lerp, roundTo, percentage, average              |
| Ruby         | array_utils       | chunk, dedupe, filter, group_by, shuffle, tail         |
| C#           | MathExtensions    | Clamp, Lerp, RoundTo, PercentageOf, Average            |
| PHP          | Arr               | get (dot notation), pluck, chunk, flatten, keyBy       |
| Dart         | date_utils        | formatDate, formatTime, isSameDay, isToday, relativeDate |
| Rust         | collection_utils  | chunk, dedupe, filter, map_vec, group_by (+ tests)     |
| Go           | sliceutil         | Chunk, Dedupe, Filter, Map, Contains (generics)        |
| Lua          | math_utils        | clamp, lerp, round, average, percentage                |
| Bash         | string.sh         | slugify, trim, lower, upper, reverse_words, repeat     |
