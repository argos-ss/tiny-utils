/**
 * http-utils — HTTP/API utilities for TypeScript
 * - Typed fetch wrappers
 * - Retry with backoff
 * - Rate limiter
 * - Response helpers
 */

export interface HttpOptions {
  method?: string;
  headers?: Record<string, string>;
  body?: unknown;
  timeout?: number;
  retries?: number;
  retryDelayMs?: number;
}

export interface HttpResponse<T = unknown> {
  ok: boolean;
  status: number;
  data: T;
  headers: Headers;
}

/**
 * Fetch with timeout, retry, and typed response.
 */
export async function request<T = unknown>(
  url: string,
  options: HttpOptions = {}
): Promise<HttpResponse<T>> {
  const {
    method = 'GET',
    headers = {},
    body,
    timeout = 30000,
    retries = 0,
    retryDelayMs = 1000,
  } = options;

  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeout);

  const fetchOptions: RequestInit = {
    method,
    headers: {
      'Content-Type': 'application/json',
      ...headers,
    },
    signal: controller.signal,
  };

  if (body && method !== 'GET') {
    fetchOptions.body = JSON.stringify(body);
  }

  let lastError: Error | null = null;

  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      const response = await fetch(url, fetchOptions);
      clearTimeout(timeoutId);

      const responseData = (await response.json().catch(() => null)) as T;

      return {
        ok: response.ok,
        status: response.status,
        data: responseData,
        headers: response.headers,
      };
    } catch (err) {
      lastError = err instanceof Error ? err : new Error(String(err));
      if (attempt < retries) {
        await sleep(retryDelayMs * Math.pow(2, attempt)); // exponential backoff
      }
    }
  }

  clearTimeout(timeoutId);
  throw lastError || new Error('Request failed');
}

/**
 * Simple rate limiter: ensures max N calls per windowMs.
 */
export class RateLimiter {
  private timestamps: number[] = [];
  constructor(private maxCalls: number, private windowMs: number) {}

  async acquire(): Promise<void> {
    const now = Date.now();
    this.timestamps = this.timestamps.filter(t => now - t < this.windowMs);
    if (this.timestamps.length >= this.maxCalls) {
      const oldest = this.timestamps[0];
      const waitMs = this.windowMs - (now - oldest) + 10;
      await sleep(waitMs);
    }
    this.timestamps.push(Date.now());
  }
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

/**
 * Quick GET request shorthand.
 */
export async function get<T = unknown>(url: string, options?: HttpOptions) {
  return request<T>(url, { ...options, method: 'GET' });
}

/**
 * Quick POST request shorthand.
 */
export async function post<T = unknown>(url: string, body?: unknown, options?: HttpOptions) {
  return request<T>(url, { ...options, method: 'POST', body });
}
