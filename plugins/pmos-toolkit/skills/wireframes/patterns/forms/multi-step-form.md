# Multi-Step Form (Wizard)

## When to use
- 4+ logical groups OR 8+ fields
- Sequential dependencies (step 2 depends on step 1's input)
- Onboarding, checkout, complex setup

## When NOT to use
- ≤ 6 fields with no dependencies → single-page form
- Steps that are peer-level not sequential → [tabs.md](../navigation/tabs.md)
- Quick edits to existing data → inline editing or modal

## Anatomy
1. Progress indicator (steps 1 of N, with labels)
2. Current step's fields
3. Step title and description
4. Navigation: Back, Next/Submit, optional "Save & exit"
5. Review/summary step before final submit (Tier 2+)

## Required states
- step-1 (no Back button)
- middle-step (Back + Next)
- last-step (Back + Submit)
- review-step (read-only summary, Edit links per section)
- in-progress save / draft saved
- submission-loading
- submission-error
- submission-success

## Best practices
1. Show progress: "Step 2 of 4: Account details" (N1) — users orient
2. Steps must be labeled by content, not just numbered (N2) — "Account / Plan / Payment / Review"
3. Allow Back without losing input (N3) — users iterate
4. Validate per step before advancing (N5) — surface errors close to source
5. Final Review step shows ALL collected data with Edit links per section (N3, N6) — last chance to fix
6. Save draft automatically on step transitions (N3) for long forms
7. Don't restart on validation error — preserve all entered data (N3)
8. Submit button only on the LAST step; Next on all others (N4)
9. Mobile: stack progress indicator vertically or use compact "2/4" pill

## Common mistakes
- No progress indicator → user doesn't know how long this takes (N1)
- Back button loses entered data → users abandon (N3)
- Validation only at the end → user has to scroll back through 4 steps to find the problem (N9)
- Submit button on every step → confusing (N4)
- No review step on long forms → users submit with errors they can't see (N5)
- Using a wizard for 4 fields → unnecessary friction (N8)

## Device variants
- **mobile-web/native**: full-screen per step, tall stepper at top
- **desktop**: side stepper or top progress bar

## Skeleton

```html
<div class="wf-stack" style="max-width:640px">
  <!-- Progress indicator -->
  <ol class="wf-row" style="list-style:none;padding:0;margin:0;gap:0;font-size:13px" aria-label="Progress">
    <li class="wf-row" style="flex:1;gap:.5rem">
      <span class="mock-pill" style="background:var(--wf-success);color:#fff">✓</span>
      <span>Account</span>
    </li>
    <li class="wf-row" style="flex:1;gap:.5rem">
      <span class="mock-pill" style="background:var(--wf-accent);color:#fff" aria-current="step">2</span>
      <strong>Plan</strong>
    </li>
    <li class="wf-row" style="flex:1;gap:.5rem">
      <span class="mock-pill">3</span>
      <span class="wf-muted">Payment</span>
    </li>
    <li class="wf-row" style="flex:1;gap:.5rem">
      <span class="mock-pill">4</span>
      <span class="wf-muted">Review</span>
    </li>
  </ol>

  <hr class="mock-divider">

  <h2 style="font-size:20px">Choose your plan</h2>
  <p class="wf-muted">You can change this later from billing settings.</p>

  <!-- Step fields here -->

  <hr class="mock-divider">
  <div class="wf-row" style="justify-content:space-between">
    <button class="mock-button">‹ Back</button>
    <button class="mock-button mock-button--primary">Continue ›</button>
  </div>
</div>
```
