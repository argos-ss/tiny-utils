# 🧰 Tiny Utils

**Small, single‑responsibility utility functions — clean code, zero duplication.**

---

## Languages

| Language   | Package / Module              | What it provides                          |
|------------|-------------------------------|-------------------------------------------|
| Python     | `str_utils`                   | `slugify`, `truncate`, `camel_to_snake`, … |
| Python     | `file_utils`                  | `read`, `write`, `size_label`, `list_tree` |
| Python     | `collection_utils`            | `chunk`, `flatten`, `dedupe`, `partition`  |
| JavaScript | `str-utils`                   | `slugify`, `truncate`, `reverseWords`      |
| JavaScript | `array-utils`                 | `chunk`, `shuffle`, `groupBy`, `dedupe`    |
| TypeScript | `date-utils`                  | `formatDate`, `daysBetween`, `relativeTime`|
| TypeScript | `type-utils`                  | `isObject`, `isString`, `expectDefined`    |
| Go         | `strutil`                     | `Slugify`, `Truncate`, `ReverseWords`      |
| Go         | `mathutil`                    | `Clamp`, `Abs`, `GCD`, `Pow`              |
| Rust       | `str_utils`                   | `slugify`, `truncate`, `reverse_words`     |
| Rust       | `math_utils`                  | `clamp`, `gcd`, `is_even`, `pow`          |
| Bash       | `colors.sh`                   | `info`, `success`, `warn`, `error`         |
| Bash       | `file-ops.sh`                 | `backup`, `dirsize`, `filecount`          |

## Design Principles

1. **Single Responsibility** — one function, one job, one file.
2. **Pure Where Possible** — no side effects, no global state.
3. **Explicit Over Implicit** — every parameter is named and documented.
4. **Zero Duplication** — shared logic is extracted, never copied.
5. **Full Test Coverage** — Rust has embedded tests; all languages include runnable examples.

## Quick Start

```python
from python.str_utils import slugify
print(slugify("Hello World!"))   # hello-world
```

```javascript
import { chunk } from "./javascript/array-utils.js";
[...chunk([1, 2, 3, 4, 5], 2)];  // [[1,2], [3,4], [5]]
```

```go
import "github.com/argos-ss/tiny-utils/go/mathutil"
mathutil.Clamp(15, 0, 10)        // 10
```

```rust
use tiny_utils::math_utils::gcd;
gcd(12, 8);                       // 4
```

## License

MIT — free for any purpose. Contributions welcome.
