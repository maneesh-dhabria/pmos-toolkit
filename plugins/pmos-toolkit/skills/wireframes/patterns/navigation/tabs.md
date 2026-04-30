# Tabs

## When to use
- Switching between **peer views of the SAME entity** (e.g., a user profile's Overview / Activity / Settings)
- 2–6 sections that don't need simultaneous visibility
- Each tab's content is roughly equal in importance

## When NOT to use
- Different destinations → use [top-nav.md](top-nav.md) or [side-nav.md](side-nav.md)
- More than 6 sections → use a side nav or accordion
- Sections that need to be compared side-by-side → split panes
- Sequential steps → use [multi-step-form.md](../forms/multi-step-form.md)

## Anatomy
1. Tab list (horizontal, 2–6 buttons)
2. Active tab indicator (underline, pill, or filled background)
3. Tab panel (the content area below)
4. Optional: count or status badge on each tab

## Required states
- default (first tab active)
- with-different-active-tab
- with-disabled-tab (rare; use sparingly)
- with-badge (count on a tab)
- mobile-scrollable (tabs overflow horizontally)

## Best practices
1. Active tab uses fill or underline (NOT just color — A2)
2. Tab labels are nouns ("Activity") not verbs ("View activity") — they describe content (N2)
3. Use `role="tablist"`, `role="tab"`, `role="tabpanel"` and arrow-key navigation (A1, A3)
4. Switching tabs should be instant or near-instant (< 100 ms) — if data fetch is needed, show skeleton (N1)
5. Don't use tabs for fundamentally different actions ("Edit" / "Delete") — those are buttons
6. First tab is the default landing — make it the most useful view (N7)
7. Persist active tab in URL (`?tab=activity`) for bookmarking and back-button (N3)

## Common mistakes
- Tabs with completely unrelated content → user expects peer views, not different pages (N4)
- 8+ tabs → exceeds Hick's Law (F2). Convert to side nav.
- Tabs and breadcrumbs both → redundant chrome (N8)
- Active tab indicated only by color → fails colorblind users (A2)
- Tab content reloads from scratch on every click → kills perceived performance

## Device variants
- **desktop-web/-app**: horizontal tabs, full visible
- **mobile-web**: horizontal scrollable tabs OR convert to a select dropdown if 4+
- **native**: iOS uses segmented control for ≤ 4; Android uses Material tabs

## Skeleton

```html
<div role="tablist" aria-label="User profile sections" class="wf-row" style="border-bottom:1px solid var(--wf-border-2)">
  <button role="tab" aria-selected="true" aria-controls="panel-overview" id="tab-overview"
          class="wf-tab" style="border-bottom:2px solid var(--wf-accent);border-radius:0">Overview</button>
  <button role="tab" aria-selected="false" aria-controls="panel-activity" id="tab-activity"
          class="wf-tab" style="border:0;border-radius:0">Activity <span class="mock-pill">12</span></button>
  <button role="tab" aria-selected="false" aria-controls="panel-settings" id="tab-settings"
          class="wf-tab" style="border:0;border-radius:0">Settings</button>
</div>

<section role="tabpanel" id="panel-overview" aria-labelledby="tab-overview" style="padding:1rem 0">
  <!-- panel content -->
</section>
```
