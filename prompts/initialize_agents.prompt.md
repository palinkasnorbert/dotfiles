---
name: initialize_agents
description: Analyze the codebase and create (or improve) an AGENTS.md file for AI coding agents working in this repo.
---

Analyze this codebase and produce an `AGENTS.md` file to guide future AI coding agents (Claude Code, Cursor, Codex, Gemini CLI, Copilot, etc.).

**Start by reading:**
- Any existing `AGENTS.md`, `GEMINI.md`, `.cursorrules`, `.cursor/rules/`, or `.github/copilot-instructions.md`
- `README.md`, `PROJECT.md`, or similar top-level docs
- Build/test config files (`package.json`, `Makefile`, `pyproject.toml`, etc.)

If an `AGENTS.md` already exists, suggest improvements to it rather than replacing it wholesale.

**Output files:**
- Always write `AGENTS.md` (read by Codex, Gemini CLI, Claude Code)
- If `.github/copilot-instructions.md` exists or the repo uses Copilot, write an identical copy there
- Do not duplicate; use a single source and symlink or note if tooling supports it

---

**What to include:**

1. **Commands** — Build, lint, test, and dev server commands. Include how to run a single test file or test case.
2. **Architecture** — High-level structure that isn't obvious from browsing files: key data flows, important abstractions, non-obvious design decisions, module boundaries. Skip anything discoverable by just listing directories.
3. **Project-specific rules** — Conventions, constraints, or gotchas that a capable developer wouldn't assume by default (e.g. "all API calls go through `src/api/client.ts`", "migrations must be run manually after schema changes").

**Always begin the file with:**
> This file provides guidance to AI coding agents like Claude Code (claude.ai/code), Cursor, Codex, Gemini CLI, GitHub Copilot, and other AI coding assistants when working with code in this repository.

---

**What to omit:**
- Generic best practices ("write tests", "don't commit secrets", "handle errors gracefully")
- File trees or component inventories that `ls` would reveal
- Anything not grounded in this specific repo — don't invent "Common Tasks" or "Tips" sections unless source material supports them
- Agent-specific syntax or file references (no `@workspace`, no Copilot variables,
  no Cursor-only directives) — the output must be plain Markdown readable by any agent

---

**Quality bar:**
- Under 500 lines
- Every rule is focused, actionable, and specific to this project
- No repetition; consolidate overlapping guidance from existing rule files
- Write it like a concise internal onboarding doc, not a style guide

**Preferred section order:** Commands → Architecture → Conventions/Gotchas
(Agents read top-to-bottom; put what they'll run first at the top)