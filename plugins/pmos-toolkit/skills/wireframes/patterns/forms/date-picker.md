# Date Picker

## When to use
- Picking a calendar date or date range
- Date matters (booking, scheduling, filtering by time period)

## When NOT to use
- Approximate / partial dates ("around 2019") → text input
- Birthdate where calendar nav is tedious → consider three selects (year/month/day) for far-past dates
- Time-only → use a time picker

## Anatomy
1. Visible label
2. Input field showing selected date (typed format hint, e.g., "MM/DD/YYYY")
3. Calendar icon trigger
4. Calendar popover: month nav, day grid, today indicator
5. For ranges: start-date + end-date fields, dual calendar
6. Optional: presets ("Today", "This week", "Last 30 days")
7. Optional: time picker (combined date+time)

## Required states
- default (empty)
- focused (input only)
- with-selected-date
- calendar-open
- with-range-selected
- with-disabled-dates (e.g., past dates blocked)
- error (invalid format / out of range)

## Best practices
1. Allow typing AND calendar selection (N7) — power users type, casual users click
2. Format hint inline with the input ("MM / DD / YYYY") (N6)
3. Today is visually highlighted in the grid (N1)
4. Disable invalid dates (past, future, blackout) — don't just error after click (N5)
5. For ranges: highlight the selected range visually as user picks the second date (N1)
6. Provide common presets above the calendar (N7) — "Last 7 days" saves clicks
7. Locale-aware: respect user's date format (en-US: MM/DD/YYYY, en-GB: DD/MM/YYYY) (N2)
8. Keyboard nav inside calendar: arrow keys move days, Enter selects, Esc closes (A3)
9. Mobile: use native `<input type="date">` for single dates (D1)

## Common mistakes
- Three separate selects for year/month/day on every date → tedious (N7). Reserve for far-past birthdates.
- No format hint → user types "5/3/24" expecting MM/DD or DD/MM (N9)
- Calendar opens behind other UI → z-index issue, frustrating
- Past dates clickable then erroring → should be disabled (N5)
- Range picker requires two separate clicks far apart → make end-date click adjacent to start

## Device variants
- **mobile-web**: native `<input type="date">` triggers system picker
- **native**: iOS wheel picker, Android Material date picker
- **desktop**: custom calendar popover with type-to-input fallback

## Skeleton

```html
<div class="wf-stack" style="max-width:280px">
  <label for="due" class="mock-label">Due date</label>
  <div class="wf-row" style="position:relative">
    <input id="due" name="due" type="text" placeholder="MM / DD / YYYY"
           class="mock-input" aria-haspopup="dialog" aria-expanded="false">
    <button class="mock-button" aria-label="Open calendar"
            style="position:absolute;right:.25rem">📅</button>
  </div>
</div>

<!-- Calendar popover (open state) -->
<div role="dialog" aria-label="Choose date" class="mock-card" style="width:300px">
  <div class="wf-row" style="justify-content:space-between">
    <button class="mock-button" aria-label="Previous month">‹</button>
    <strong>April 2026</strong>
    <button class="mock-button" aria-label="Next month">›</button>
  </div>
  <hr class="mock-divider">
  <div style="display:grid;grid-template-columns:repeat(7,1fr);gap:.25rem;text-align:center;font-size:12px">
    <span class="wf-muted">Su</span><span class="wf-muted">Mo</span><span class="wf-muted">Tu</span>
    <span class="wf-muted">We</span><span class="wf-muted">Th</span><span class="wf-muted">Fr</span><span class="wf-muted">Sa</span>
    <!-- day cells, with .wf-accent on today, .wf-muted on prev/next month -->
  </div>
</div>
```
