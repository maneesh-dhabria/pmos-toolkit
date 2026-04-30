# Resolve or Create Feature Folder

Shared procedure for pipeline skills that produce or consume feature-scoped artifacts. Every pipeline skill calls this **after product-context loading** and **before any artifact work**. Returns the absolute path to the feature folder, the slug, and whether the folder was newly created.

Callers pass:
- `skill_name` — e.g. `requirements`, `spec`, `plan`, `wireframes`
- `feature_arg` — value of `--feature <slug>` if the user provided it; otherwise empty
- `feature_hint` — a short feature-name string the skill has from user input (used to derive a default slug for new folders); may be empty

The folder lives at `{docs_path}/{YYYY-MM-DD}_{slug}/` where `{docs_path}` was resolved by `product-context/context-loading.md` and the date is the folder *creation* date.

## Step 1: Explicit `--feature` argument

If `feature_arg` is non-empty:
- Look for a folder matching `{docs_path}/*_{feature_arg}/` (any date prefix).
- **Exactly one match:** use it. Update `.pmos/current-feature` to that folder name. Echo: `Using feature folder: <path>`. Return.
- **Zero matches:** error. Echo: `No feature folder matching '{feature_arg}'. Available: <list of slugs from existing feature folders>`. Stop. Do **not** auto-create — explicit `--feature` is a precise lookup.
- **Multiple matches:** error. Echo: `Multiple feature folders match '{feature_arg}': <list>`. Stop.

## Step 2: Read pointer file

Read `.pmos/current-feature` if present. The file contains a single line: the folder name (e.g., `2026-04-30_verify-skill-teeth`).
- **Pointer present and folder exists:** use it. Echo: `Using feature folder: <path>`. Return.
- **Pointer present but folder missing (stale):** warn `Pointer references missing folder '<x>' — clearing.` Delete the pointer file. Continue to Step 3.
- **Pointer absent:** continue to Step 3.

## Step 3: Prompt the user

Use `AskUserQuestion`-style prompt (see `_shared/interactive-prompts.md`):

> What feature is this for?

Options, in order:
1. `Create new: <derived-slug>` — only if `feature_hint` is non-empty. Derive `<derived-slug>` per the **Slug Rules** section below.
2. Up to 5 most-recently-modified existing feature folders, one option each, labeled by folder name.
3. `Other...` — free-text input. The text is treated as either an existing slug to look up (per Step 1 logic) or a new slug to create.

## Step 4: Create new (when chosen)

If the user picks **Create new** or types a new slug under **Other...**:

1. Show the derived (or typed) slug. Prompt: `Slug: <derived-slug> [Enter to accept, edit to override]`. Accept the user's edited value if any.
2. Validate the final slug against **Slug Rules** below. On failure, show the rule that was violated and re-prompt.
3. **Collision check:** if `{docs_path}/*_{slug}/` already matches an existing folder (any date), abort the create. Show the existing folder and prompt:
   - `Use existing <folder-name>` — switch to that folder.
   - `Pick a different slug` — re-prompt for slug.
4. Create the directory `{docs_path}/{today}_{slug}/` where `{today}` is the current date `YYYY-MM-DD`.
5. Write `.pmos/current-feature` containing the folder name (single line, no trailing newline issues — use plain echo).
6. Echo: `Created feature folder: <path>`. Return.

## Step 5: Existing folder (when chosen)

If the user picks an existing folder:
1. Update `.pmos/current-feature` to that folder name.
2. Echo: `Using feature folder: <path>`. Return.

## Slug Rules

- Lowercase only.
- Kebab-case: alphanumeric (`a-z`, `0-9`) and hyphens only. No underscores, spaces, slashes.
- Max 40 characters.
- No leading or trailing hyphens.
- No double hyphens (collapse runs).

**Auto-derivation from a feature hint:**
1. Lowercase the hint.
2. Replace any run of non-alphanumeric characters with a single hyphen.
3. Strip leading/trailing hyphens.
4. Truncate at 40 characters; if the truncation lands mid-word, prefer truncating at the previous hyphen if that keeps the slug ≥20 chars.

## Pointer File

`.pmos/current-feature` is repo-local plain text, one line: the folder name only (no path, no quotes). Default `.gitignore`d. Cleared by manual edit, by Step 2 (stale), or by future `/feature done` command (out of scope for v1).
