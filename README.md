<p align="center">
  <img src="assets/banner.png" alt="Pennacle Security" width="720">
</p>

# pennacle-security/.github

The plumbing repo for the [pennacle-security](https://github.com/pennacle-security) org. No product code lives here, on purpose. What lives here instead:

- the [org profile page](profile/README.md) that renders on github.com/pennacle-security
- org-wide community health files (they apply to every public repo in the org unless a repo ships its own)
- a scheduled workflow that keeps the project table on that profile in sync with reality

[![Refresh org profile](https://github.com/pennacle-security/.github/actions/workflows/refresh-profile.yml/badge.svg)](https://github.com/pennacle-security/.github/actions/workflows/refresh-profile.yml)

## File map

| Path | What it is | Applies to |
|---|---|---|
| [`profile/README.md`](profile/README.md) | The org profile: banner, live project table, how we work, contact | the org profile page |
| [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md) | Short version: be decent | every repo |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Ground rules plus per-project appendices (summit, cairnlock) | every repo |
| [`SECURITY.md`](SECURITY.md) | Supported versions, private disclosure process, scope | every repo |
| [`PULL_REQUEST_TEMPLATE.md`](PULL_REQUEST_TEMPLATE.md) | What / Why / How tested | every repo |
| [`.github/ISSUE_TEMPLATE/`](.github/ISSUE_TEMPLATE) | Bug report and feature request forms | every repo |
| [`scripts/refresh_profile.sh`](scripts/refresh_profile.sh) | Rebuilds the project table from the GitHub API | this repo |
| [`.github/workflows/refresh-profile.yml`](.github/workflows/refresh-profile.yml) | Runs the script on a schedule, commits when the table changed | this repo |

## How the live project table works

The block between these two comments in [`profile/README.md`](profile/README.md) is machine-written:

```
<!-- BEGIN:ORG-PORTFOLIO (auto-generated - do not edit) -->
...
<!-- END:ORG-PORTFOLIO (auto-generated - do not edit) -->
```

`scripts/refresh_profile.sh` lists the org's public repos through the GitHub API (description, language, stars, forks, open issues, last push), renders them as a markdown table, and swaps it into the block. Everything outside the markers is human-written and the script will not touch it.

It runs:

- every 30 minutes on a schedule
- on pushes to `main` in this repo that touch the script or the workflow
- on demand: **Actions > Refresh org profile > Run workflow**, or

  ```bash
  gh api repos/pennacle-security/.github/dispatches -f event_type=refresh-profile
  ```

The workflow only commits when the rendered table actually differs from what is on disk, so a quiet org means a quiet commit log.

## Adding a repo to the table

You do not edit this repo. Create a public repo in the org, write a description, done - it shows up in the table within half an hour, sorted by most recent push. Archived repos are skipped, and so is this one.

## Notes

- Security problems are never reported through issues. See [SECURITY.md](SECURITY.md).
- The banner is hand-made. If you edit it, keep the org name legible at 720px.
