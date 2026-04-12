# Learning Capture Instructions

Reference document for pipeline skills. Follow these steps at the END of every pipeline skill, after workstream enrichment and before the handoff to the next skill.

---

## Step 1: Read or Create the Learnings File

1. Check if `~/.pmos/learnings.md` exists
2. **If not found:** Create it with this header:

   ```markdown
   # Pipeline Learnings

   Global patterns and skill improvement notes captured across projects.
   Keep this file under 300 lines — summarize when exceeded.

   ---
   ```

3. **If found:** Read the full file

---

## Step 2: Check Line Count and Summarize if Needed

If the file exceeds 300 lines, run summarization **before** appending new learnings:

1. Read the full file
2. Summarize per section — merge overlapping bullets, tighten wording, remove any that are project-specific noise. Target: reduce each section by ~40%
3. Show the diff to the user:

   ```
   Pipeline Learnings file is over 300 lines. Proposing a consolidation:

   ## /spec (was 12 bullets → 7)
   - [merged bullet]
   - [tightened bullet]
   - [removed: too project-specific]

   Apply consolidation? (y/n/edit)
   ```

4. **If approved:** Write the consolidated file
5. **If declined:** Proceed anyway — file grows past 300 temporarily, next run will re-trigger

**Summarization rules:**
- Never delete a section entirely — keep the heading even if all bullets were consolidated
- Merge bullets that express the same insight in different words
- Remove bullets that turned out to be project-specific noise
- The user sees exactly what changes before anything is written

---

## Step 3: Reflect and Propose Learnings

1. Reflect on the current session:
   - What went wrong or was harder than it should have been?
   - What prompting gap or missing instruction in this skill caused friction?
   - What pattern would help future runs of this skill across any project?

2. Filter — only keep learnings that are:
   - **Global**: Not tied to a specific project, repo, or workstream
   - **Actionable**: Specific enough to change behavior (not "be more thorough")
   - **Novel**: Not already captured in substance under this skill's section in the learnings file

3. Propose 0-3 learnings to the user:

   ```
   Based on this session, I'd add to Pipeline Learnings:

   ## /skill-name
   + Prompt for failure modes explicitly when user only describes happy path

   Add these learnings? (y/n/edit)
   ```

4. **If approved:** Append bullets under the `## /skill-name` section. If the section doesn't exist, create it at the end of the file.
5. **If declined or nothing to add:** "No new global learnings from this session." Move on to the handoff.

**Rules:**
- Proposing 0 learnings is fine and expected for smooth sessions — do not force capture
- Never auto-write — always show the user what you'd add
- Each bullet should make sense to someone who wasn't in this session
- The learning targets the skill's instructions, not the user's project
- Flat bullets only, no nesting
