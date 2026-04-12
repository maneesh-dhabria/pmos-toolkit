# Resolve Pipeline Input

Shared procedure for pipeline skills that consume a prior-phase document. Callers pass:
- `phase` — the subdirectory under `{docs_path}` to search (e.g., `requirements`, `specs`, `plans`)
- `label` — human-readable name for prompts (e.g., "requirements doc", "spec", "plan")

Try resolution steps in order. Stop at the first hit. Always echo the resolved path on a single line before proceeding — this is the user's only chance to catch a wrong pick.

## Step 1: Explicit argument

If the user passed an argument to the slash command:
- If it resolves to an existing file path, use it. Echo: `Using: <path>`
- Otherwise treat the argument as inline content. Echo: `Using inline <label> from argument`

Proceed. Skip remaining steps.

## Step 2: Conversation history

Scan this session for any file under `{docs_path}/{phase}/` that was written, edited, or read earlier. If one or more exist, pick the most recently touched. Echo: `Using from this session: <path>`

Proceed. Skip remaining steps. Do not prompt — the echo is the confirmation; the user can interrupt if wrong.

## Step 3: Numbered picker

List files in `{docs_path}/{phase}/` sorted by mtime (newest first), keeping up to 3.

- **0 files:** Report `No {label} found in {docs_path}/{phase}/` and ask the user to provide a path or inline content. Do not proceed until provided.
- **1 file:** Skip the list. Echo: `Using: <path>` and proceed.
- **2–3 files:** Present a numbered list:

  ```
  Recent {label}s in {docs_path}/{phase}/:
    [1] <path>  (modified <mtime>)
    [2] <path>  (modified <mtime>)
    [3] <path>  (modified <mtime>)
  Pick one [default 1]:
  ```

  On confirmation (including empty input → 1), echo: `Using: <path>` and proceed.
