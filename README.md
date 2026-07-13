# VibeGuard: Security Skills for Vibe Coders

**Don't ship what Cursor forgot to lock down.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## What is VibeGuard?

VibeGuard is a collection of **auto-activating security skills** for AI coding agents (Claude Code, Cursor, OpenCode, Windsurf, Codex, Replit Agent, GitHub Copilot).

91.5% of vibe-coded apps contain security vulnerabilities. VibeGuard catches the issues your AI assistant forgets to check.

## What's Included (Free Version)

This repository contains **3 free skills** from the full VibeGuard pack:

1. **Prompt Injection Defense** — Catch malicious user input before it reaches your LLM
2. **Dependency Vetting** — Audit packages before `npm install` with Socket.dev
3. **OWASP Top 10 Code Review** — Full OWASP checklist mapped to AI-generated code

### Full VibeGuard Pack ($19)

The complete pack includes **15 skills** covering:
- API Key Safety
- Secure Deployment
- Database Security
- Authentication Safety
- File Upload Security
- Rate Limiting
- Logging & Monitoring
- Supply Chain Security
- SKILL.md File Vetting
- Sandbox & Isolation
- Incident Response
- Security Testing

**Get the full pack → [vibeguard.dev](https://vibeguard.dev)** *(link active after launch)*

## Installation

### Auto-install (recommended)
```bash
chmod +x install.sh
./install.sh
```

### Manual
```bash
# Claude Code
cp -r skills/ ~/.claude/skills/

# Cursor
cp -r skills/ ~/.cursor/skills/

# OpenCode
cp -r skills/ ~/.opencode/skills/
```

That's it. Skills auto-activate when you hit a risky pattern.

## How It Works

Each skill has:
- **Trigger conditions** — activates automatically when you hit a risky pattern
- **Security checklist** — what to verify before shipping
- **Copy-paste fix prompts** — paste into your agent, get the fix
- **Red flags** — what to look for in AI-generated code

### Example Workflow

```
1. You're about to install a new package
2. The "dependency-vetting" skill auto-activates
3. AI checks: npm audit, GitHub stars, last commit date, known CVEs
4. You get a safety score + recommendations
5. You decide whether to install
```

## Why VibeGuard?

❌ **Not reference material.** Most open-source security skills are 1,000-line markdown files you'll never read. VibeGuard ships with copy-paste fix prompts.

❌ **Not for security pros.** This is for vibe coders who ship on Friday and don't have time to read OWASP ASVS 5.0.

✅ **Auto-activates.** Skills trigger when you hit risky patterns. No manual invocation.

✅ **Stack-aware.** Works with Next.js, Supabase, Firebase, Stripe, Vercel — the vibe coder's stack.

✅ **Tested on real incidents.** Built from analysis of CodeRabbit PwnedRabbit, Lovable CVE-2025-48757 (CVSS 9.3), Cursor CVE-2025-54136 (CVSS 8.8), and the awstore.cloud attack.

## Works With

✅ Claude Code · ✅ Cursor · ✅ OpenCode · ✅ Windsurf · ✅ Codex · ✅ Replit Agent · ✅ GitHub Copilot · ✅ Any agent that supports markdown skill files

## The Vibe-Coding Security Crisis

VibeGuard was built after researching the security crisis of 2026:

- **91.5%** of vibe-coded apps have vulnerabilities (SymbioticSec)
- **36%** of SKILL.md files on GitHub contain security flaws (Snyk)
- **awstore.cloud malware attack** (April 2026) affected 1M+ repos
- **Lovable CVE-2025-48757**: CVSS 9.3, 170+ apps exposed
- **Cursor CVE-2025-54136**: CVSS 8.8, remote code execution

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Changelog

**v1.0 (July 2026)**
- Initial release: 3 free skills (Prompt Injection, Dependency Vetting, OWASP Code Review)
- Full pack: 15 skills available at vibeguard.dev

---

**Built by vibe coders, for vibe coders.**

Don't ship what Cursor forgot to lock down.
