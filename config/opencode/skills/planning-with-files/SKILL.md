---
name: planning-with-files
description: Structured file-based planning with PLAN.md
license: MIT
compatibility: opencode
metadata:
  audience: all
  workflow: planning
---

## What I do

I help you plan and track work using a `PLAN.md` file in the project root.

## How I work

### 1. Create PLAN.md

When a new task starts, create or update `PLAN.md` with these sections:

- **## Goals** — What we're trying to achieve
- **## Constraints & Preferences** — Non-negotiable requirements
- **## Progress** — Track completed (done), in-progress, and blocked items
- **## Key Decisions** — Important choices made during the task
- **## Next Steps** — Ordered list of remaining work
- **## Critical Context** — Essential info the next agent/session needs
- **## Relevant Files** — Key file paths with brief descriptions

### 2. Update as you go

- Keep `PLAN.md` in sync with actual progress
- Mark items `### Done`, `### In Progress`, `### Blocked`
- Append to **Key Decisions** whenever you make an important choice
- At the end of a session, write a **## Session Summary** section

### 3. Keep it concise

- One `PLAN.md` per task or feature
- Prefer bullet points over long paragraphs
- Include file paths and line numbers when referencing code
