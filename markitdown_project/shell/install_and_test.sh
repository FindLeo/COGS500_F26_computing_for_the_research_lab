#!/usr/bin/env bash
# Install the course-project command and record focused smoke tests in one log.
set -euo pipefail
project_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
export R2MD_PROJECT_DIR="$project_dir"
run_id=$(date -u +%Y%m%dT%H%M%SZ)
run_dir="$project_dir/runs/cli_$run_id"
mkdir -p "$run_dir"
log_file="$run_dir/cli_tests.log"

# sha256sum on Linux; shasum ships with macOS instead.
sha256() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$@"; else shasum -a 256 "$@"; fi
}

finish() {
  status=$?
  trap - EXIT
  printf '\nTest script exit status: %s\n' "$status" >> "$log_file"
  cp "$log_file" "$HOME/markitdown_cli_$run_id.log"
  python3 - "$project_dir" "$log_file" "$HOME/markitdown_cli_$run_id.zip" <<'PY'
import sys
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
project, log, target = map(Path, sys.argv[1:])
with ZipFile(target, "w", ZIP_DEFLATED) as archive:
    archive.write(log, "cli_tests.log")
    for name in ("pixi.toml", "pixi.lock", "bin/r2md", "skills/research-to-markdown/SKILL.md"):
        source = project / name
        if source.is_file(): archive.write(source, name)
print(f"Attach this evidence file: {target}")
PY
  printf 'Log: %s/markitdown_cli_%s.log\n' "$HOME" "$run_id"
  exit "$status"
}
trap finish EXIT

expect_rejection() {
  if "$@"; then
    printf 'FAIL: invalid operation unexpectedly succeeded.\n'
    return 1
  else
    printf 'Expected rejection; exit status: %s\n' "$?"
  fi
}

main() {
  printf 'CLI installation and tests: %s\n' "$run_id"
  uname -srm
  [[ -f "$project_dir/pixi.lock" ]] || { printf 'Missing pixi.lock\n'; return 1; }
  command -v pixi
  pixi --version
  sha256 "$project_dir/pixi.toml" "$project_dir/pixi.lock" "$project_dir/bin/r2md"
  cp "$project_dir/pixi.lock" "$run_dir/lock_before"
  sha256 "$project_dir"/inputs/* > "$run_dir/input_hashes_before.txt"

  printf '\nInstall command and skill\n'
  mkdir -p "$HOME/.local/bin"
  chmod +x "$project_dir/bin/r2md"
  target="$HOME/.local/bin/r2md"
  if [[ -e "$target" || -L "$target" ]]; then
    [[ -L "$target" && $(readlink "$target") == "$project_dir/bin/r2md" ]] || {
      printf 'Existing r2md is not this project link; leaving it unchanged: %s\n' "$target"
      return 1
    }
  else
    ln -s "$project_dir/bin/r2md" "$target"
  fi
  skill_dir="$project_dir/.agents/skills/research-to-markdown"
  mkdir -p "$skill_dir"
  if [[ -e "$skill_dir/SKILL.md" ]]; then
    cmp -s "$project_dir/skills/research-to-markdown/SKILL.md" "$skill_dir/SKILL.md" || {
      printf 'A different skill already exists: %s\n' "$skill_dir/SKILL.md"
      return 1
    }
  else
    cp "$project_dir/skills/research-to-markdown/SKILL.md" "$skill_dir/SKILL.md"
  fi
  printf 'Skill installed: %s\n' "$skill_dir/SKILL.md"
  printf -v startup_line 'source %q' "$project_dir/shell/env.sh"
  if ! grep -Fqx "$startup_line" "$HOME/.bashrc" 2>/dev/null; then
    printf '\n# Research to Markdown project\n%s\n' "$startup_line" >> "$HOME/.bashrc"
  fi
  source "$project_dir/shell/env.sh"

  printf '\n1. New interactive shell resolves the alias and executable\n'
  bash -ic 'type -a r2md'

  printf '\n2. Non-interactive PATH invocation handles spaces\n'
  sample="$run_dir/input with spaces.docx"
  cp "$project_dir/inputs/project_proposal.docx" "$sample"
  bash --noprofile --norc -c 'command -v r2md; r2md "$1" -o "$2"' _ "$sample" "$run_dir/path output.md"

  printf '\n3. Compare PATH and alias results with direct Pixi output\n'
  pixi run --locked --manifest-path "$project_dir/pixi.toml" markitdown "$sample" -o "$run_dir/direct.md"
  bash --noprofile --norc -O expand_aliases -c $'source "$R2MD_PROJECT_DIR/shell/env.sh"\ntype r2md\nr2md "$1" -o "$2"' _ "$sample" "$run_dir/alias.md"
  cmp "$run_dir/direct.md" "$run_dir/path output.md"
  cmp "$run_dir/direct.md" "$run_dir/alias.md"
  printf 'PASS: all three invocation routes produced identical Markdown.\n'

  printf '\n4. Existing output is protected\n'
  expect_rejection "$target" "$sample" -o "$run_dir/path output.md"
  cmp "$run_dir/direct.md" "$run_dir/path output.md"

  printf '\n5. Missing input is rejected\n'
  expect_rejection "$target" "$run_dir/missing.pdf" -o "$run_dir/missing.md"
  [[ ! -e "$run_dir/missing.md" ]]

  printf '\n6. Source path is rejected as output (it fails the .md output check)\n'
  expect_rejection "$target" "$sample" -o "$sample"
  cmp "$sample" "$project_dir/inputs/project_proposal.docx"

  printf '\n7. PPTX invocation and limitation message\n'
  "$target" "$project_dir/inputs/git_slides.pptx" -o "$run_dir/git_slides.md"
  wc -lc "$run_dir/git_slides.md"

  printf '\n8. Original sources and lockfile remain unchanged\n'
  sha256 -c "$run_dir/input_hashes_before.txt"
  cmp "$run_dir/lock_before" "$project_dir/pixi.lock"
  printf 'PASS: original sources and lockfile unchanged.\n'

  printf '\nCodex CLI availability: '
  if command -v codex; then
    printf 'Live agent invocation has not been performed by this script.\n'
  else
    printf 'Not found on PATH. Live agent invocation remains untested.\n'
  fi
  printf '\nPASS: all command tests completed. Actual HPC execution and live skill use remain pending.\n'
}

main > "$log_file" 2>&1
