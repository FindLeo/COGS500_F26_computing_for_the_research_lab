#!/usr/bin/env bash
# One live Codex skill test. Install and sign into Codex before running this file.
set -euo pipefail
project_dir=${R2MD_PROJECT_DIR:-"$HOME/markitdown_project"}
cd "$project_dir"
source "$project_dir/shell/env.sh"
command -v codex >/dev/null || { printf 'Codex CLI is not on PATH. Install it and sign in first.\n' >&2; exit 1; }
skill="$project_dir/.agents/skills/research-to-markdown/SKILL.md"
[[ -f "$skill" ]] || { printf 'The project skill is not installed.\n' >&2; exit 1; }
run_id=$(date -u +%Y%m%dT%H%M%SZ)
run_dir="$project_dir/runs/skill_$run_id"
mkdir -p "$run_dir"
evidence_dir=${R2MD_EVIDENCE_DIR:-"$HOME"}
mkdir -p "$evidence_dir"
log_file="$run_dir/full_skill_test.log"

cat > "$run_dir/prompt.txt" <<'PROMPT'
Use $research-to-markdown, installed at .agents/skills/research-to-markdown/SKILL.md, to analyze inputs/git_slides.pptx.

Create a fresh Markdown copy using the skill's conversion workflow. Explain the relationship on slide 20 and what the screenshot examples on slide 53 communicate. Describe what the converted content lets you establish and any uncertainty or information loss relevant to those answers.

This is a test of the installed skill. Use the source document, the installed skill, the existing converter, and the newly created Markdown. Do not use prior conversion outputs, evaluation notes, or earlier test logs to answer. Do not modify the software, the skill, source files, or environment configuration. If execution is blocked, report the concrete error and stop instead of changing permissions or bypassing restrictions.
PROMPT
printf '\nWrite the Markdown copy at this exact new path: %s\n' "$run_dir/converted.md" >> "$run_dir/prompt.txt"

{
  printf 'Live skill test started (UTC): %s\n' "$run_id"
  codex --version
  printf '\nPrompt:\n'
  cat "$run_dir/prompt.txt"
  printf '\nCommand: codex exec --json --sandbox workspace-write --skip-git-repo-check -o %q -\n' "$run_dir/answer.md"
} > "$log_file" 2>&1
sha256sum "$project_dir"/inputs/* "$project_dir/pixi.lock" "$project_dir/bin/r2md" "$skill" > "$run_dir/hashes_before.txt"

printf 'Running one Codex skill test; results will be saved to %s\n' "$log_file"
if codex exec --json --sandbox workspace-write --skip-git-repo-check \
  -o "$run_dir/answer.md" - < "$run_dir/prompt.txt" \
  > "$run_dir/events.jsonl" 2> "$run_dir/diagnostics.log"; then
  session_status=0
else
  session_status=$?
fi
overall_status=$session_status
{
  printf '\nCodex exit status: %s\n\nComplete event stream:\n' "$session_status"
  cat "$run_dir/events.jsonl"
  printf '\nDiagnostics:\n'
  cat "$run_dir/diagnostics.log"
  printf '\nSource and configuration preservation:\n'
  if sha256sum -c "$run_dir/hashes_before.txt"; then
    printf 'All recorded input/configuration hashes are unchanged.\n'
  else
    overall_status=1
  fi
  if [[ -s "$run_dir/converted.md" ]]; then
    printf '\nGenerated Markdown lines/bytes: '
    wc -lc < "$run_dir/converted.md"
    sha256sum "$run_dir/converted.md"
  else
    printf '\nNo nonempty converted Markdown file was produced.\n'
    overall_status=1
  fi
  if [[ -f "$run_dir/answer.md" ]]; then
    printf '\nFinal agent answer:\n'
    cat "$run_dir/answer.md"
  fi
  printf '\nFinished (UTC): %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'Harness exit status: %s. Review the event stream and answer to assess skill use.\n' "$overall_status"
} >> "$log_file" 2>&1

python3 - "$run_dir" "$evidence_dir/markitdown_skill_$run_id.zip" <<'PY'
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
import sys
folder, target = map(Path, sys.argv[1:])
with ZipFile(target, 'w', ZIP_DEFLATED) as archive:
    for name in ('full_skill_test.log', 'prompt.txt', 'events.jsonl', 'diagnostics.log', 'answer.md', 'converted.md', 'hashes_before.txt'):
        path = folder / name
        if path.is_file(): archive.write(path, name)
print(f'Attach this evidence file: {target}')
PY
exit "$overall_status"
