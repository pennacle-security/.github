# Contributing

Short version: open an issue first for anything bigger than a typo, keep PRs small, and match the style of the code around you.

## Ground rules, every project

- Open an issue before starting anything bigger than a typo fix. If we disagree with the direction, we would rather tell you before you have written 800 lines.
- Tests pass before you push. `pytest -q` everywhere for now.
- Commit style: short imperative subject, lowercase, no fluff. "feat: two-stage xss check", not "major improvements!!!".
- No new dependencies without discussion.
- Tooling never ships with a blind-spray default. Safe defaults are a feature, not an afterthought.

## summit

1. Subclass `Check` from `summit/scan/core.py`. Set `check_id`, `title`, `severity`.
2. `run(point, client)` receives one injection point and the HTTP client. Return findings. Use the baseline-diff pattern - compare against an unmodified request of the same parameter. Checks that fire on everything are worse than no check.
3. Register it in `summit/scan/modules/__init__.py`.
4. Add at least one test. If the check needs a live target, `examples/vuln_app.py` seeds one, and it never touches the internet.
5. Set `confidence` honestly: `confirmed` only when the finding is an observed fact (raw reflection, file content, a fresh database error, a 3xx Location). Heuristics stay `potential`.

## cairnlock

- Same stdlib-first policy as summit: Python 3.10+, no new dependencies without discussion.
- Every new rule ships with two fixtures: one that triggers it, one that does not. A rule that fires on everything trains people to ignore the output, which is worse than a missing rule.
- CLI output is an interface. Changing the default output format is a breaking change - say so in the PR description.

## Reporting bugs

Use the bug issue template. Include the command you ran and the JSON report if you have one. If a finding did not reproduce, label it `false-positive` - those get priority, because they cost us trust.
