# /prototype Smoke Test Recipe

End-to-end verification needs a real feature folder with `/wireframes` output. Run this after installing the skill (`/reload-plugins` or restart Claude Code).

## Recipe

1. Pick a feature folder that already has `/wireframes` output (look under `docs/features/`).
2. Run `/pmos-toolkit:prototype <path-to-req-doc>` for that feature.
3. Verify each phase:

| Phase | Verification |
|-------|--------------|
| 0 | Skill loads workstream + learnings without error; feature folder resolves |
| 1 | Detects existing wireframes; auto-triggers `/wireframes` if missing |
| 2 | Honors tier gating (Tier 1 exits, Tier 2 prompts, Tier 3 announces mandatory) |
| 3 | Generates `assets/<entity>.json` with domain-real data; user review prompt fires |
| 4 | Generates `runtime.js`, `components.js`, `styles.css` (parallel where possible); `prototype.css` copied |
| 5 | Produces one `index.<device>.html` per device that opens cleanly in a browser; all screens reachable |
| 6 | Reviewer subagent runs ≤2 loops per file; review log appears as HTML comment at top of each device file |
| 7 | Friction pass produces `interactive-friction.md` (capped at 5 journeys) |
| 8 | Findings surface via `AskUserQuestion` (≤4 per batch, capped at 12 total) |
| 9 | Landing `index.html` generated; both URL + file path printed |
| 10 | Req doc gets `## Prototype` section appended; commit succeeds |
| 11 | Workstream enriched if loaded in Phase 0 |
| 12 | Capture-learnings reflection runs |

## Browser checks (after generation)

Open `index.html` and each `index.<device>.html`:

- [ ] No console errors on first paint
- [ ] Every wireframe screen reachable via navigation
- [ ] Forms validate and submit (mock latency 200–800ms)
- [ ] CRUD persists across navigations (lost on reload — correct)
- [ ] Loading / error / empty states visible
- [ ] `?inject-errors=/some/path` triggers the error state for that route
- [ ] Opening directly via `file://` works (inline-data fallback kicks in)
- [ ] Mock data feels domain-real (no "User 1", no Lorem ipsum)
- [ ] High-fi styling matches wireframes' brand tokens

## If any phase fails

Capture in `~/.pmos/learnings.md` under `## /prototype`:

```markdown
- {date}: {phase} failed because {reason}. Fix: {what would prevent this}.
```

Re-run after fix. Iterate.
