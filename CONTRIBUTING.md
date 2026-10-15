# Contributing

Short version: open an issue first for anything bigger than a typo, keep PRs small, and match the style of the code around you.

## Adding a scan check (summit)

1. Subclass `Check` from `summit/scan/core.py`. Set `check_id`, `title`, `severity`.
2. `run(point, client)` receives one injection point and the HTTP client. Return findings. Use the baseline-diff pattern - compare against an unmodified request of the same parameter. Checks that fire on everything are worse than no check.
3. Register it in `summit/scan/modules/__init__.py`.
4. Add at least one test. If the check needs a live target, `examples/vuln_app.py` seeds one, and it never touches the internet.
5. Set `confidence` honestly: `confirmed` only when the finding is an observed fact (raw reflection, file content, a fresh database error, a 3xx Location). Heuristics stay `potential`.

## Ground rules

- Python 3.10+, stdlib + requests only. No new dependencies without discussion.
- Every network-touching check needs a safe default: probe hosts that cannot resolve (`.example`), localhost-only demo targets, no third-party callback servers.
- Tests must pass: `pytest -q`.
- Commit style: short imperative subject, lowercase, no fluff. "feat: two-stage xss check", not "major improvements!!!".

## Reporting bugs

Use the bug issue template. Include the command you ran and the JSON report if you have one. If a finding did not reproduce, label it `false-positive` - those get priority, because they cost us trust.
