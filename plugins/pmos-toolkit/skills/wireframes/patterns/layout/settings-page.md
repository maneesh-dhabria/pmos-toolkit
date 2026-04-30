# Settings Page

## When to use
- Grouped configurable preferences (account, workspace, notifications)
- Long, infrequently-edited configuration

## When NOT to use
- 1–2 settings → put inline where the feature is used
- Frequently changed values → don't bury in settings; expose in main UI
- Onboarding-style forms → use [multi-step-form.md](../forms/multi-step-form.md)

## Anatomy
1. [page-header.md](page-header.md): "Settings" title, optional save state
2. [two-column-layout.md](two-column-layout.md): categories rail on left
3. Right pane: section groups
4. Each setting row: label + description + control (input/toggle/select)
5. Save model: per-row inline save OR bottom-sticky "Save changes" bar

## Required states
- view (read-only display)
- with-pending-changes (save bar visible)
- saving
- saved
- with-permission-denied (show why user can't edit)
- with-validation-error

## Best practices
1. Group settings by intent: Profile, Notifications, Security, Billing (G1)
2. Each setting: bold label, muted description below, control on the right (G3)
3. Save model:
   - Toggles save instantly (N1)
   - Forms with multiple fields use a sticky bottom save bar (N3)
   - Mixing the two on one page is OK as long as toggles are clearly auto-saved
4. Show "Saved" toast / inline indicator after instant saves (N1)
5. Destructive settings (delete account, leave workspace) at the bottom, in a separate "Danger zone" group, styled distinctly (N5, G1)
6. Categories rail uses [two-column-layout.md](two-column-layout.md) with sticky positioning
7. Mobile: rail becomes a single back-link or top accordion (D1)
8. Search settings (`⌘K`) for products with > 30 settings (N7, F2)

## Common mistakes
- Mixing instant-save and form-save without indication → user can't tell what's persisted (N1)
- Destructive actions mixed with normal settings → accidental clicks (N5, G1)
- Long flat list with no grouping → unscannable (G1, F2)
- No confirmation on destructive (delete account) → catastrophic mistakes (N5)
- Settings hidden 3 levels deep → users can't find them (F2, N6)

## Device variants
- **desktop-web/-app**: two-column with rail
- **mobile**: single column; rail becomes top accordion or category list page

## Skeleton

```html
<header style="margin-bottom:1.5rem">
  <h1 style="margin:0">Settings</h1>
</header>

<div style="display:grid;grid-template-columns:220px 1fr;gap:1.5rem">
  <aside class="mock-sidebar" style="width:auto;height:fit-content;position:sticky;top:1rem">
    <div class="wf-stack">
      <a href="#" class="mock-button" style="justify-content:flex-start;background:var(--wf-accent);color:#fff">Profile</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Notifications</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Security</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Billing</a>
      <a href="#" class="mock-button" style="justify-content:flex-start;color:var(--wf-error)">Danger zone</a>
    </div>
  </aside>

  <main class="wf-stack">
    <section class="mock-card">
      <h2 style="margin:0 0 .5rem;font-size:16px">Profile</h2>
      <div class="wf-stack">
        <div class="wf-row" style="justify-content:space-between;align-items:flex-start">
          <div>
            <div style="font-weight:500">Display name</div>
            <div class="wf-muted" style="font-size:13px">Shown across the workspace.</div>
          </div>
          <input class="mock-input" value="Maneesh Dhabria" style="max-width:240px">
        </div>
        <hr class="mock-divider">
        <div class="wf-row" style="justify-content:space-between">
          <div>
            <div style="font-weight:500">Marketing emails</div>
            <div class="wf-muted" style="font-size:13px">Product updates and tips.</div>
          </div>
          <button role="switch" aria-checked="true" class="mock-button mock-button--primary">On</button>
        </div>
      </div>
    </section>

    <!-- Sticky save bar -->
    <div class="wf-row" style="position:sticky;bottom:0;background:var(--wf-surface);border-top:1px solid var(--wf-border-2);padding:.75rem;justify-content:flex-end">
      <button class="mock-button">Discard</button>
      <button class="mock-button mock-button--primary">Save changes</button>
    </div>
  </main>
</div>
```
