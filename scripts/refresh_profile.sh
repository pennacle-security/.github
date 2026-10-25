#!/usr/bin/env bash
#
# refresh_profile.sh - regenerate the project table on the org profile page.
#
# Lists the org's public repos through the GitHub API, renders them as a
# markdown table and swaps the result into the block between the BEGIN/END
# markers in profile/README.md. Everything outside the markers is left
# untouched, so hand-written prose stays hand-written.
#
# Exits 0 either way; the workflow decides whether to commit by looking at
# git status. Requires gh (with GH_TOKEN), jq and awk - all preinstalled on
# GitHub's ubuntu runners.

set -euo pipefail

ORG="${ORG:-pennacle-security}"
README_FILE="${README_FILE:-profile/README.md}"
export BEGIN_MARK='<!-- BEGIN:ORG-PORTFOLIO (auto-generated - do not edit) -->'
export END_MARK='<!-- END:ORG-PORTFOLIO (auto-generated - do not edit) -->'

command -v gh >/dev/null 2>&1 || { echo "error: gh is required" >&2; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "error: jq is required" >&2; exit 1; }
[[ -f "$README_FILE" ]] || { echo "error: $README_FILE not found" >&2; exit 1; }
grep -qF "$BEGIN_MARK" "$README_FILE" || { echo "error: BEGIN marker missing in $README_FILE" >&2; exit 1; }
grep -qF "$END_MARK" "$README_FILE" || { echo "error: END marker missing in $README_FILE" >&2; exit 1; }

# --- pull the org's public repos (paginated) ---------------------------------
repos="$(gh api --paginate "orgs/${ORG}/repos?per_page=100&type=public")"

# name, url, description, homepage, language, stars, forks, issues, last push.
# .github is meta plumbing, not a project - skip it. Archived repos would just
# rot in the table, so they are skipped too. Pipes in descriptions are swapped
# for slashes - a raw pipe would break the markdown table cell.
data="$(printf '%s' "$repos" | jq -rs '
  [.[][]]
  | map(select(.archived != true and .disabled != true and .name != ".github"))
  | sort_by(.pushed_at) | reverse | .[]
  | [
      .name,
      .html_url,
      ((.description // "") | gsub("[\\t\\n\\r]"; " ") | gsub("[|]"; "/")),
      ((.homepage // "") | sub("/$"; "")),
      (.language // ""),
      (.stargazers_count | tostring),
      (.forks_count | tostring),
      (.open_issues_count | tostring),
      (.pushed_at | .[0:10])
    ]
  | @tsv
')"

# shields.io badge for the language, colored like the GitHub linguist chart
lang_badge() {
  local lang="$1" color logo=""
  [[ -z "$lang" ]] && { printf -- '-'; return; }
  case "$lang" in
    Python)     color=3572A5; logo=python ;;
    Go)         color=00ADD8; logo=go ;;
    Rust)       color=DEA584; logo=rust ;;
    JavaScript) color=f1e05a; logo=javascript ;;
    TypeScript) color=3178c6; logo=typescript ;;
    Shell)      color=89e051; logo=gnubash ;;
    C)          color=555555; logo=c ;;
    'C++')      color=f34b7d; logo=cplusplus ;;
    'C#')       color=178600; logo=csharp ;;
    Java)       color=b07219; logo=java ;;
    HTML)       color=e34c26; logo=html5 ;;
    CSS)        color=563d7c; logo=css3 ;;
    Ruby)       color=701516; logo=ruby ;;
    PHP)        color=4F5D95; logo=php ;;
    PowerShell) color=012456; logo=powershell ;;
    Kotlin)     color=A97BFF; logo=kotlin ;;
    Swift)      color=F05138; logo=swift ;;
    Dart)       color=00B4AB; logo=dart ;;
    *)          color=8b949e; logo='' ;;
  esac
  local enc; enc="$(jq -rn --arg s "$lang" '$s | @uri')"
  if [[ -n "$logo" ]]; then
    printf '![%s](https://img.shields.io/badge/%s-%s?logo=%s&logoColor=white&style=flat-square)' "$lang" "$enc" "$color" "$logo"
  else
    printf '![%s](https://img.shields.io/badge/%s-%s?style=flat-square)' "$lang" "$enc" "$color"
  fi
}

stamp="$(date -u +'%Y-%m-%d %H:%M UTC')"

rows=""
count=0 stars=0 forks=0 issues=0

if [[ -n "$data" ]]; then
  while IFS=$'\t' read -r name url desc homepage lang rs rf ri pushed; do
    count=$((count + 1))
    stars=$((stars + rs))
    forks=$((forks + rf))
    issues=$((issues + ri))
    row="| [**${name}**](${url})"
    [[ -n "$homepage" ]] && row+=" · [site](${homepage})"
    row+=" | ${desc} | $(lang_badge "$lang") | ${rs} | ${rf} | ${ri} | ${pushed} |"
    rows+="${row}"$'\n'
  done <<< "$data"
fi

plural=""; [[ $count -ne 1 ]] && plural="s"
block=$'\n'
block+="**${count} public project${plural} · ${stars} stars · ${forks} forks · refreshed ${stamp}**"$'\n\n'
if [[ $count -eq 0 ]]; then
  block+="_Nothing public yet._"$'\n\n'
else
  block+="| Project | What it is | Language | Stars | Forks | Issues | Last push |"$'\n'
  block+="|---|---|---|---:|---:|---:|---|"$'\n'
  block+="${rows}"$'\n'
fi

export PORTFOLIO_BLOCK="$block"

# --- swap the block, keep everything outside the markers ----------------------
tmp="$(mktemp)"
awk '
  index($0, ENVIRON["BEGIN_MARK"]) { print; printf "%s", ENVIRON["PORTFOLIO_BLOCK"]; skip = 1; next }
  skip && index($0, ENVIRON["END_MARK"]) { skip = 0 }
  !skip { print }
' "$README_FILE" > "$tmp"

if cmp -s "$tmp" "$README_FILE"; then
  echo "portfolio table unchanged - $README_FILE left as is"
  rm -f "$tmp"
else
  mv "$tmp" "$README_FILE"
  echo "portfolio table refreshed in $README_FILE"
fi
