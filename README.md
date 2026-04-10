# Agent Skills

A collection of reusable skills for Claude Code, Codex CLI, and other AI coding agents. Skills are slash-command workflows (`/verify`, `/spec`, `/plan`, etc.) that guide agents through structured processes.

## Repository Structure

```
agent-skills/
├── skills/          User-created skills (pipeline, utilities, custom workflows)
├── plugins/         Plugin-contributed skills (e.g., impeccable design ecosystem)
├── agents/          Shared agent definitions
└── link-skills.sh   Symlink setup script
```

### Skills (User-Created)

| Skill | Description |
|-------|-------------|
| `/requirements` | Brainstorm and shape a requirements document — first pipeline stage |
| `/creativity` | Structured creativity techniques for non-obvious improvements (optional enhancer) |
| `/msf` | Motivation, Satisfaction, Friction analysis with PSYCH scoring (optional enhancer) |
| `/spec` | Technical specification from requirements — second pipeline stage |
| `/plan` | Execution plan from a spec — third pipeline stage |
| `/execute` | Implement a plan end-to-end with TDD and verification |
| `/verify` | Post-implementation verification gate — lint, test, review, QA |
| `/changelog` | Generate user-facing changelog entries after merging to main |
| `/session-log` | Capture learnings, decisions, and patterns from a session |
| `/create-skill` | Create a new skill with cross-platform conventions |
| `/macos-battery-drain-diagnostics` | Diagnose battery drain, orphaned processes, and cleanup opportunities |

**Pipeline flow:**
```
/requirements  →  [/msf, /creativity]  →  /spec  →  /plan  →  /execute  →  /verify
                   optional enhancers
```

### Plugins (Impeccable Design Ecosystem)

23 design and frontend skills for building production-grade interfaces:

| Skill | Description |
|-------|-------------|
| `/impeccable` | Create distinctive, production-grade frontend interfaces |
| `/critique` | Evaluate design from a UX perspective with quantitative scoring |
| `/shape` | Plan UX and UI before writing code |
| `/audit` | Accessibility, performance, theming, and responsive design checks |
| `/adapt` | Responsive design across screen sizes and devices |
| `/animate` | Purposeful animations and micro-interactions |
| `/arrange` | Improve layout, spacing, and visual rhythm |
| `/bolder` | Amplify safe designs to be more visually impactful |
| `/clarify` | Improve UX copy, error messages, and microcopy |
| `/colorize` | Add strategic color to monochromatic designs |
| `/delight` | Add moments of joy and personality |
| `/distill` | Strip designs to their essence |
| `/extract` | Extract reusable components and design tokens |
| `/harden` | Error handling, i18n, and edge case resilience |
| `/normalize` | Realign UI to design system standards |
| `/onboard` | Design onboarding flows and first-run experiences |
| `/optimize` | Diagnose and fix UI performance issues |
| `/overdrive` | Technically ambitious implementations — shaders, physics, 60fps |
| `/polish` | Final quality pass on alignment, spacing, and consistency |
| `/quieter` | Tone down overstimulating designs |
| `/typeset` | Fix typography hierarchy, sizing, and readability |

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/maneeshdhabria/agent-skills.git ~/Desktop/Projects/agent-skills
```

### 2. Run the link script

The link script creates individual symlinks from your agent config directories into the skills discovery path. By default it targets:

- `~/.claude-personal/skills/`
- `~/.claude-workmax/skills/`
- `~/.codex-work/skills/`

Edit the `CONFIG_DIRS` array in `link-skills.sh` to match your setup, then run:

```bash
./link-skills.sh
```

This symlinks every skill (from both `skills/` and `plugins/`) into each config directory so the CLI discovers them as `/skill-name`.

### 3. Verify

Open a new Claude Code or Codex session. Your skills should appear in the skill list. Try `/verify` or `/spec` to confirm.

### Custom Config Directories

If your agent config lives somewhere other than the defaults, update `CONFIG_DIRS` in `link-skills.sh`:

```bash
CONFIG_DIRS=(
  "$HOME/.my-claude-config"
  "$HOME/.my-codex-config"
)
```

Then re-run the script.

## Adding Your Own Skills

Use the `/create-skill` command inside a session, or manually:

1. Create `skills/<skill-name>/SKILL.md` with the required frontmatter:

```yaml
---
name: my-skill
description: What it does. When to use it. Natural trigger phrases.
user-invocable: true
argument-hint: "<what to pass>"
---
```

2. Run `./link-skills.sh` to update symlinks.

User-created skills go in `skills/`. Plugin-contributed skills go in `plugins/`. This separation keeps the repo browsable without affecting discovery — the CLI sees all skills identically.

## How Discovery Works

The CLI scans the `skills/` directory in your config folder for subdirectories containing `SKILL.md`. Each skill is identified by its directory name. The `link-skills.sh` script merges both `skills/` and `plugins/` into a flat set of symlinks so the CLI finds everything in one place.

No manifest, registry, or configuration file is needed — it's purely filesystem-based.

## Requirements

- Claude Code, Codex CLI, or another agent that supports skill discovery via `~/.*/skills/` directories
- Bash (for `link-skills.sh`)
