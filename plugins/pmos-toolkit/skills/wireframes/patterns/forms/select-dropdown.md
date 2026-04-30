# Select Dropdown

## When to use
- Pick **one** from **4–15** known, finite options
- Options too long to show as radio buttons (≥ 6) but bounded enough to enumerate

## When NOT to use
- 2–3 options → use radio buttons (always-visible, faster) or a segmented control
- 15+ options → use a [search.md](search.md) with autocomplete or a combobox
- Multi-select needed → multi-select dropdown or checkbox list (different pattern)
- Options not knowable in advance → autocomplete

## Anatomy
1. Visible label above
2. Trigger (the closed select)
3. Dropdown list (the opened panel)
4. Selected-value display in trigger
5. Chevron icon (visual cue it's a dropdown)
6. Optional: option groups with headers, search filter for 10+ options

## Required states
- default (no selection)
- with-selection
- focused / open
- disabled
- error
- with-search (10+ options)
- option-hovered

## Best practices
1. Always have a default option — either a real default or a placeholder ("Select a country") (N7)
2. Sort options meaningfully: alphabetical for known names, frequency for repeated picks, chronological for dates (N4)
3. Group related options with `<optgroup>` headers (G1)
4. For 10+ options, add type-to-search inside the dropdown (N7, F2)
5. Trigger shows the selected value, not the field name (N6)
6. Native `<select>` on mobile — better UX than custom (D1)
7. Custom selects: `role="combobox"`, full keyboard support (Enter/Space to open, arrow-key navigation, Esc to close) (A1, A3)
8. Show only ~7 options visible at once; scroll the rest (F2, G4)

## Common mistakes
- 30+ options unsorted → users can't find their answer (F2, N4)
- Custom-styled select that breaks mobile native picker → worse UX everywhere (D1)
- Dropdown opens upward when there's room below → unexpected (N4)
- No visual cue that it's a dropdown (no chevron) → looks like a static label
- Fails keyboard navigation → unusable for power users and screen-reader users (A3)

## Device variants
- **mobile-web**: native `<select>` opens system picker (best UX)
- **native**: iOS wheel picker, Android Material menu
- **desktop**: custom or native; custom allows search/grouping

## Skeleton

```html
<div class="wf-stack" style="max-width:320px">
  <label for="country" class="mock-label">Country</label>
  <select id="country" name="country" class="mock-input">
    <option value="" disabled selected>Select a country</option>
    <optgroup label="Frequent">
      <option>United States</option>
      <option>India</option>
      <option>United Kingdom</option>
    </optgroup>
    <optgroup label="All countries">
      <option>Argentina</option>
      <option>Australia</option>
      <option>Brazil</option>
      <option>Canada</option>
    </optgroup>
  </select>
</div>
```
