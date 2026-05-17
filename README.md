# 🧰 Tiny Utils

**Small, single‑responsibility utility functions — clean code, zero duplication.**

---

## Languages

| #  | Language   | Files                              | Provides                                      |
|----|------------|------------------------------------|-----------------------------------------------|
| 1  | 🐍 Python  | `str_utils`, `file_utils`, `collection_utils` | slugify, truncate, read, write, chunk, dedupe |
| 2  | 🟨 JavaScript | `str-utils`, `array-utils`        | slugify, truncate, shuffle, groupBy           |
| 3  | 🔵 TypeScript | `date-utils`, `type-utils`        | formatDate, relativeTime, type guards         |
| 4  | ☕ Java     | `StringUtils`                      | slugify, truncate (+ JUnit 5 test)            |
| 5  | 🟣 Kotlin   | `Collections`                      | chunked, dedupeBy, groupByNonNull             |
| 6  | 🍎 Swift    | `StringUtils`                      | slugify, truncate                             |
| 7  | 💎 Ruby     | `string_utils`                     | slugify, truncate, titleize                   |
| 8  | #️⃣ C#       | `StringExtensions` (+ xUnit test)  | Slugify, Truncate (extension methods)         |
| 9  | 🐘 PHP      | `Str`                              | slugify, truncate, startsWith, endsWith       |
| 10 | 🎯 Dart     | `string_utils`, `math_utils`       | slugify, truncate, gcd, lcm                   |
| 11 | 🔶 Rust     | `str_utils`, `math_utils`          | slugify, truncate, clamp, gcd (+ tests)       |
| 12 | 🔷 Go       | `strutil`, `mathutil`              | Slugify, Clamp, GCD, Pow (generics)           |
| 13 | 🌙 Lua      | `str`, `table_utils`               | slugify, truncate, chunk, shuffle             |
| 14 | 🐚 Bash     | `colors`, `file-ops`               | info, success, backup, dirsize                |

## Design Principles

1. **Single Responsibility** — one function, one job, one file.
2. **Pure Where Possible** — no side effects, no global state.
3. **Explicit Over Implicit** — every parameter is named and documented.
4. **Zero Duplication** — shared logic is extracted, never copied.
5. **Test Coverage** — Rust, Java, C# include runnable tests.

## Quick Start

```python
from python.str_utils import slugify
slugify("Hello World!")   # hello-world
```

```javascript
import { chunk } from "./javascript/array-utils.js";
[...chunk([1, 2, 3, 4, 5], 2)];  // [[1,2], [3,4], [5]]
```

```dart
import 'dart/string_utils.dart';
slugify('Hello World!');   // hello-world
```

```rust
use tiny_utils::math_utils::gcd;
gcd(12, 8);                 // 4
```

## License

MIT — free for any purpose. Contributions welcome.
