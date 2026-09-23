# Research documents to Markdown

Course project by Si-Yang (Leo) Liu. Evaluate Microsoft MarkItDown using Pixi, describe information preserved or lost, and package the tested workflow as a Codex skill.

## Current status (2026-09-23)

- Six original documents collected; file formats verified and SHA-256 hashes recorded in `notes/source_inventory.json`.
- `pixi.toml` prepared for macOS ARM and Linux x86-64 with Python 3.12 and MarkItDown PDF, DOCX, and PPTX extras.
- The student reported installing Pixi 0.81.0 and the project environment in Google Cloud Shell (Linux x86-64). MarkItDown 0.1.8 was reported there.
- Checkpoints for all six documents were selected before their respective conversions. The student's consolidated Cloud Shell log confirms six successful commands; all six outputs have been qualitatively evaluated. See `notes/conversion_results.md`.
- The PATH wrapper and alias passed eight real Cloud Shell checks, including equality with direct Pixi output, paths with spaces, source preservation, and rejection of invalid output paths.
- One explicit live skill invocation passed in Cloud Shell with Codex CLI 0.156.0. The agent created fresh Markdown before analysis and consulted the source for visual information. See `notes/skill_evaluation.md`. Actual HPC execution and local-model integration remain untested.

The commands below show the original Cloud Shell location, `~/markitdown_project`. If you use this folder inside another repository, run `export R2MD_PROJECT_DIR="$PWD"` from the project directory before using the command or sourcing `shell/env.sh`. The automated tests also require the six original files in `inputs/`, which are listed in `notes/sources.md` and `notes/source_inventory.json`.

## Repeatable complete log in Google Cloud Shell

Upload `shell/run_all_conversions.sh` to Cloud Shell, then run it from the home directory:

```bash
bash "$HOME/run_all_conversions.sh"
```

The script runs all six files in a fixed order. It creates a timestamped `runs/<UTC timestamp>/` folder containing each Markdown output and `full_conversion.log`, then copies the log into the Cloud Shell home directory for easy download. The log records versions, input and output hashes, commands, exit codes, image-reference checks, and the complete default Markdown output. It does not overwrite previous `outputs/`. Transfer the single log file for review; Cloud Shell files are not automatically visible in the local Codex workspace. Describe examples and limitations without assigning a numeric score.

`pixi.toml` declares the environment; `pixi.lock` records resolved versions. The workflow was tested on Linux x86-64 in Google Cloud Shell. The manifest also lists macOS ARM, but execution there and on an actual HPC cluster remains untested.

## Command and alias

The project wrapper at `bin/r2md` invokes MarkItDown through the locked Pixi environment, requires a new `.md` output path, and reports format-specific review points. Follow `notes/next_tests.md` to install it on PATH and test it. Its interface is:

```bash
r2md /absolute/path/input.docx -o /absolute/path/new-output.md
```

The original converter remains available through a direct Pixi command:

```bash
pixi run --locked --manifest-path "$HOME/markitdown_project/pixi.toml" markitdown /absolute/path/input.docx -o /absolute/path/output.md
```

After running the new installer, load the PATH and alias settings into the current terminal:

```bash
source "$HOME/markitdown_project/shell/env.sh"
r2md /absolute/path/input.docx -o /absolute/path/output.md
```

The name means **research to Markdown**. The current alias points to the wrapper; both were tested in Cloud Shell. `R2MD_PROJECT_DIR` selects a project outside the default `~/markitdown_project`. Batch jobs should source `shell/env.sh` before invoking `r2md`.

## Remaining work

The software experiments are complete for this course test in Cloud Shell. Review the final report under Introduction, Analysis, Evaluation, and Resources, and create and share the required project notebook. The student confirmed that the notebook has not yet been started. Review the work, make it your own, and acknowledge AI assistance.

## Repository contents

The GitHub source package contains this README, the Pixi manifest and lockfile, `bin/`, `shell/`, `skills/`, `.agents/skills/`, and `notes/`. The `.agents/skills/` copy lets Codex discover the skill when this project folder is the working directory. The original sample documents, generated Markdown, complete run logs, local environment, and draft report are kept outside version control. Their sources and the results needed to understand the experiment are documented in `notes/sources.md`, `notes/source_inventory.json`, and the evaluation notes. To rerun conversions, download the samples into `inputs/` using those sources, verify their hashes, and install the locked environment.
