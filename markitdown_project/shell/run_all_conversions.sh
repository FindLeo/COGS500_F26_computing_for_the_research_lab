#!/usr/bin/env bash
# Run the six course-project conversions in a fixed order and keep one complete log.
set -u

project_dir=${R2MD_PROJECT_DIR:-"$HOME/markitdown_project"}
if ! cd "$project_dir"; then
  printf 'Project directory is unavailable: %s\n' "$project_dir" >&2
  exit 1
fi

run_id=$(date -u +%Y%m%dT%H%M%SZ)
run_dir="$project_dir/runs/$run_id"
if ! mkdir -p "$run_dir/outputs"; then
  printf 'Cannot create run directory: %s\n' "$run_dir" >&2
  exit 1
fi
log_file="$run_dir/full_conversion.log"
# Exit statuses 0-6 count failed files; setup errors use values above that range.
setup_error=100

# sha256sum on Linux; shasum ships with macOS instead.
sha256() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$@"; else shasum -a 256 "$@"; fi
}

image_audit() {
  python3 - "$1" <<'PY'
import re
import sys
from pathlib import Path

output = Path(sys.argv[1])
markdown = output.read_text(encoding="utf-8", errors="replace")
targets = re.findall(r"!\[[^\]]*\]\(([^)]+)\)", markdown)
relative = sorted({
    target.strip("<>") for target in targets
    if not target.startswith(("data:", "http://", "https://", "/"))
})
missing = [target for target in relative if not (output.parent / target).exists()]
print(f"Image references: {len(targets)}; unique relative targets: {len(relative)}; missing targets: {len(missing)}")
if missing:
    print("First missing targets: " + ", ".join(missing[:8]))
PY
}

main() {
  printf 'Research documents to Markdown — complete conversion log\n'
  printf 'Started (UTC): %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  printf 'Project: %s\nRun directory: %s\n' "$project_dir" "$run_dir"
  printf 'System: '; uname -srm
  if ! command -v pixi; then
    printf 'ERROR: pixi is not on PATH.\n'
    return "$setup_error"
  fi
  pixi --version
  if [[ ! -f pixi.lock ]]; then
    printf 'ERROR: pixi.lock is missing; a locked run cannot proceed.\n'
    return "$setup_error"
  fi
  printf 'Manifest and lockfile SHA-256:\n'
  sha256 pixi.toml pixi.lock
  printf 'Installed MarkItDown version: '
  pixi run --locked --manifest-path "$project_dir/pixi.toml" python -c 'from importlib.metadata import version; print(version("markitdown"))'

  local failures=0
  local index=0
  local filename input output result
  local files=(
    project_proposal.docx
    rdm_quiz.docx
    git_cheatsheet.pdf
    datalad_cheatsheet.pdf
    unix_slides.pptx
    git_slides.pptx
  )

  for filename in "${files[@]}"; do
    ((index += 1))
    input="$project_dir/inputs/$filename"
    output="$run_dir/outputs/${filename%.*}.md"
    printf '\n========== FILE %s/%s: %s ==========\n' "$index" "${#files[@]}" "$filename"
    if [[ ! -f "$input" ]]; then
      printf 'ERROR: input file is missing: %s\n' "$input"
      ((failures += 1))
      continue
    fi
    printf 'Input SHA-256: '; sha256 "$input"
    printf 'Command: pixi run --locked --manifest-path %q markitdown %q -o %q\n' "$project_dir/pixi.toml" "$input" "$output"
    if pixi run --locked --manifest-path "$project_dir/pixi.toml" markitdown "$input" -o "$output"; then
      result=0
    else
      result=$?
      ((failures += 1))
    fi
    printf 'Exit status: %s\n' "$result"
    if [[ -f "$output" ]]; then
      printf 'Output lines/bytes: '; wc -lc < "$output"
      printf 'Output SHA-256: '; sha256 "$output"
      image_audit "$output"
      printf '%s\n' '----- BEGIN COMPLETE MARKDOWN -----'
      cat "$output"
      printf '\n%s\n' '----- END COMPLETE MARKDOWN -----'
    else
      printf 'No Markdown output file was created.\n'
    fi
  done

  printf '\nFinished (UTC): %s\nFailures: %s/%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$failures" "${#files[@]}"
  return "$failures"
}

main > "$log_file" 2>&1
status=$?
printf 'Conversion run finished. Log: %s\n' "$log_file"
download_copy="$HOME/markitdown_conversion_$run_id.log"
if cp "$log_file" "$download_copy"; then
  printf 'Copy for download: %s\n' "$download_copy"
else
  printf 'Could not copy the log to the home directory; use the original log path above.\n' >&2
fi
if ((status == setup_error)); then
  printf 'The run could not start; see the log for the error.\n'
else
  printf 'Successful files: %s/6\n' "$((6 - status))"
fi
exit "$status"
