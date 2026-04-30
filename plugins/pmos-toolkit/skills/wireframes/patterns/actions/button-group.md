# Button Group

## When to use
- Related actions (Cancel + Save, Back + Next)
- Mutually exclusive choices (segmented control)
- 2–4 peer actions

## When NOT to use
- One dominant action → [primary-cta.md](primary-cta.md)
- 5+ actions → [dropdown-menu.md](dropdown-menu.md) or split into groups
- Toggle on/off → use a switch / toggle pattern

## Anatomy
1. Container (flex row, sometimes vertical)
2. 2–4 buttons, one styled as primary
3. Optional: separator/divider for segmented control variant

## Required states
- default
- with-one-loading (e.g., Save in progress)
- one-disabled
- segmented-with-selected
- mobile-stacked-vertical

## Best practices
1. ONE primary in a group; rest are secondary/tertiary (G3)
2. Order matters by platform:
   - Web/Material/Android: Cancel left, primary right (N4)
   - iOS: Cancel left, primary right OR primary in nav bar
3. Equal heights (G2)
4. Consistent spacing between buttons (G4)
5. On mobile narrow: stack vertically with primary on top OR bottom (test both)
6. Segmented control: equal-width children, current state visually filled (G2, A2)
7. Don't mix button sizes within a group (G2)

## Common mistakes
- Two primaries → user can't tell which is the right answer (G3)
- Primary on left, Cancel on right (against convention) → users mis-click (N4)
- Different heights/sizes → looks broken (G2)
- 6 buttons in a row → overflow on narrow viewports (G4)
- Segmented control with 5+ segments → labels truncate (F2)

## Device variants
- **desktop**: horizontal row
- **mobile narrow**: stack vertically; primary on top (saves a thumb-stretch)
- **ios-app**: prefer segmented control for mutually exclusive
- **android-app**: Material chip group or button group

## Skeleton

```html
<!-- Cancel + primary, web convention -->
<div class="wf-row" style="justify-content:flex-end">
  <button class="mock-button">Cancel</button>
  <button class="mock-button mock-button--primary">Save changes</button>
</div>

<!-- Three-way action -->
<div class="wf-row" style="justify-content:space-between">
  <button class="mock-button">‹ Back</button>
  <div class="wf-row">
    <button class="mock-button">Save draft</button>
    <button class="mock-button mock-button--primary">Publish ›</button>
  </div>
</div>

<!-- Segmented control -->
<div role="radiogroup" aria-label="View mode" class="wf-row" style="border:1px solid var(--wf-border-2);border-radius:var(--wf-radius);padding:2px">
  <button role="radio" aria-checked="true"
          class="mock-button mock-button--primary" style="border:0;border-radius:6px;flex:1">Day</button>
  <button role="radio" aria-checked="false"
          class="mock-button" style="border:0;background:transparent;flex:1">Week</button>
  <button role="radio" aria-checked="false"
          class="mock-button" style="border:0;background:transparent;flex:1">Month</button>
</div>
```
