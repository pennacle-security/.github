# Security policy

## Supported versions

| Version | Supported |
| --- | --- |
| 1.1.x | yes |
| < 1.1 | no |

## Reporting a vulnerability

Do not open a public issue for security problems. Use GitHub's private vulnerability reporting on the affected repo (Security tab, then Report a vulnerability). If that is unavailable, contact the maintainers directly.

What to include:

- affected repo, and version or commit
- reproduction steps or a proof of concept
- impact as you see it

What to expect:

- acknowledgment within 72 hours
- a fix or a mitigation plan within 14 days for confirmed issues
- public credit once the fix ships, unless you prefer to stay anonymous

## Scope

Public projects today: summit (web security testing platform) and cairnlock (AI-agent context file analyzer). Deliberately vulnerable demo code (the `examples/` directory in summit) is insecure on purpose - issues in demo code only count if they break out of the demo.

We only test systems we have written permission to test, and we expect the same from everyone contributing here.
