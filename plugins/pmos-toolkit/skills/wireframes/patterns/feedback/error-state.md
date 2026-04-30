# Error State

## When to use
- Component or screen-level failure (load failed, save failed, network error)
- 404 / 403 / 500 error pages
- Background sync failures

## When NOT to use
- Field-level errors → [inline-error.md](inline-error.md)
- Page-level warnings → [banner.md](banner.md)
- Transient action failures → [toast.md](toast.md) with retry

## Anatomy
1. Icon (error-themed, ⚠ or specific to context)
2. Title: what failed
3. Helper text: why (in plain language) + what to do
4. Primary recovery action: Retry, Reload, Go back
5. Optional: error code / technical details (collapsed)
6. Optional: "Contact support" link with pre-filled context

## Required states
- network-error (offline / unreachable)
- server-error (5xx)
- not-found (404)
- forbidden (403)
- generic-failure
- with-retry-in-progress

## Best practices
1. Title in plain language — "Couldn't load deals" not "Error 503" (N9, N2)
2. Helper text explains and offers a path forward (N9)
3. Primary action is Retry (or Reload, Go home) (N3)
4. Error code shown for support but de-emphasized (N9) — collapse it under "Show details"
5. Don't blame the user for system errors (N9)
6. `role="alert"` for the container (A1)
7. Color + icon + text (A2)
8. For network errors, suggest checking connection (N9)
9. Auto-retry transparent failures with exponential backoff; show error only after several attempts

## Common mistakes
- "Error: 500" with no context → user can't act (N9)
- "Something went wrong" with no recovery → dead end (N3, N9)
- Stack trace shown to end user → confusing, looks broken (N9)
- Same error state for network vs server vs not-found → wrong recovery action suggested (N4)
- No retry → user has to refresh whole page

## Device variants
- **desktop / mobile**: centered in container; respect safe-area on native
- **native**: use platform-specific empty/error illustrations and CTAs

## Skeleton

```html
<!-- Component error -->
<div class="wf-message wf-message--error" role="alert">
  <div style="font-size:32px" aria-hidden="true">⚠</div>
  <div class="wf-message__title">Couldn't load deals</div>
  <div class="wf-message__hint">Check your internet connection and try again.</div>
  <div class="wf-row" style="margin-top:.5rem">
    <button class="mock-button mock-button--primary">Retry</button>
    <button class="mock-button">Reload page</button>
  </div>
  <details style="margin-top:.5rem;font-size:12px">
    <summary class="wf-muted">Show details</summary>
    <code class="wf-mono">503 Service Unavailable · req-id 8H3kZ29p</code>
  </details>
</div>

<!-- 404 page-level -->
<div class="wf-message">
  <div style="font-size:48px;font-weight:700">404</div>
  <div class="wf-message__title">We couldn't find that page</div>
  <div class="wf-message__hint">It may have been moved or deleted.</div>
  <div class="wf-row" style="margin-top:.5rem">
    <button class="mock-button mock-button--primary">Go to dashboard</button>
    <button class="mock-button">Contact support</button>
  </div>
</div>
```
