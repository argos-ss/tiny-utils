# 🧰 Tiny Utils

**Small, reusable utility classes and functions in multiple programming languages.**

Every developer has that collection of snippets they copy between projects. This is mine — curated, tested, and ready to use.

## Languages

| Language   | Modules                                          |
|------------|--------------------------------------------------|
| Python     | `str_utils`, `file_utils`                        |
| JavaScript | `str-utils`, `array-utils`                       |
| TypeScript | `date-utils`, `type-utils`                       |
| Go         | `strutil`, `mathutil`                            |
| Rust       | `str_utils`, `math_utils`                        |
| Bash       | `colors`, `file-ops`                             |

## Usage

```python
from python import slugify
print(slugify("Hello World!"))  # hello-world
```

```javascript
import { chunk } from 'javascript/array-utils.js';
chunk([1,2,3,4,5], 2); // [[1,2],[3,4],[5]]
```

```typescript
import { formatDate } from 'typescript/date-utils.ts';
formatDate(new Date(), 'YYYY-MM-DD'); // 2026-05-17
```

## License

MIT — use freely, contribute if you find something useful.
  - Daily update: 2026-05-17 21:19
