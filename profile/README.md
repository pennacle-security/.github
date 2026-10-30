<p align="center">
  <img src="https://raw.githubusercontent.com/pennacle-security/.github/main/assets/banner.png" alt="Pennacle Security" width="720">
</p>

<p align="center">
  <a href="https://github.com/pennacle-security/summit/actions/workflows/tests.yml"><img src="https://github.com/pennacle-security/summit/actions/workflows/tests.yml/badge.svg" alt="summit CI"></a>
  <a href="https://github.com/pennacle-security/cairnlock/actions/workflows/ci.yml"><img src="https://github.com/pennacle-security/cairnlock/actions/workflows/ci.yml/badge.svg" alt="cairnlock CI"></a>
  <a href="https://github.com/pennacle-security/summit/releases"><img src="https://img.shields.io/github/v/tag/pennacle-security/summit?label=summit&color=2ea44f" alt="summit latest release"></a>
  <a href="https://github.com/pennacle-security/.github/actions/workflows/refresh-profile.yml"><img src="https://github.com/pennacle-security/.github/actions/workflows/refresh-profile.yml/badge.svg" alt="profile refresh status"></a>
</p>

Independent offensive security team. We break web applications with written permission, hunt bugs on public bounty programs, and ship the tooling we use in the field.

Everything on this page is written by hand except the project table. A workflow in [.github](https://github.com/pennacle-security/.github) re-reads the org's public repos every 30 minutes and rewrites that one block, so the numbers you see are the numbers that exist.

## What we ship

<!-- BEGIN:ORG-PORTFOLIO (auto-generated - do not edit) -->

**2 public projects · 5 stars · 4 forks · refreshed 2026-10-30 21:39 UTC**

| Project | What it is | Language | Stars | Forks | Issues | Last push |
|---|---|---|---:|---:|---:|---|
| [**summit**](https://github.com/pennacle-security/summit) · [site](https://pennacle-security.github.io/summit) | Open-source web security testing platform: proxy, scanner and fuzzer in one CLI. By Pennacle Security. | ![Python](https://img.shields.io/badge/Python-3572A5?logo=python&logoColor=white&style=flat-square) | 4 | 3 | 6 | 2026-10-29 |
| [**cairnlock**](https://github.com/pennacle-security/cairnlock) · [site](https://pennacle-security.github.io/cairnlock) | Static analyzer and lockfile for AI-agent context files: AGENTS.md, CLAUDE.md, MCP configs, skill folders. | ![Python](https://img.shields.io/badge/Python-3572A5?logo=python&logoColor=white&style=flat-square) | 1 | 1 | 1 | 2026-10-28 |

<!-- END:ORG-PORTFOLIO (auto-generated - do not edit) -->

## What we do

| | |
|---|---|
| **Bug bounty** | HackerOne, Bugcrowd and private programs. Web apps, APIs, mobile backends. |
| **Manual pentesting** | No scanner-only reports. Every finding is hand-verified, with reproduction steps. |
| **Tooling** | We build and open-source the tools we wished we had when we were starting out. |

## How we work

- **Permission first.** We do not touch systems we are not authorized to test, and neither should you.
- **Verification over volume.** A finding we cannot reproduce does not leave the building.
- **False positives are bugs.** Our scanner reports carry confidence labels for a reason - "it fired wrong" gets a regression test, not a shrug.

## The tools, one paragraph each

**[summit](https://github.com/pennacle-security/summit)** - a web security testing platform that puts an intercepting proxy, an active scanner and a fuzzer behind a single CLI. It is built for people who read the report, which is why every finding carries a confidence label and the raw request/response pair that produced it. Docs at [pennacle-security.github.io/summit](https://pennacle-security.github.io/summit/). MIT licensed.

**[cairnlock](https://github.com/pennacle-security/cairnlock)** - a static analyzer and lockfile for the files that steer AI agents: AGENTS.md, CLAUDE.md, MCP configs, skill folders. Agent context is supply chain now, and almost nobody diffs it. cairnlock pins it, tracks changes to it, and flags the parts that should never have reached your agent's instructions in the first place. Docs at [pennacle-security.github.io/cairnlock](https://pennacle-security.github.io/cairnlock/). MIT licensed.

## Get involved

- **Bugs and ideas:** open an issue on the relevant repo. The org-wide issue forms live in [.github](https://github.com/pennacle-security/.github).
- **Code:** skim [CONTRIBUTING.md](https://github.com/pennacle-security/.github/blob/main/CONTRIBUTING.md) first. Small PRs, honest confidence labels, tests that pass before you push.
- **Found a security issue in something we ship?** Report it privately and we will fix it and credit you. See the [security policy](https://github.com/pennacle-security/.github/blob/main/SECURITY.md).

## Contact

GitHub issues on our repos for now - a proper contact page is coming.

---

Only test systems you are authorized to test. Seriously.
