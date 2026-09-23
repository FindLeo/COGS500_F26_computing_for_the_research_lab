# CLI and alias evaluation

Evidence: `runs/cli_20260923T022540Z/cli_tests.log`, supplied by the student from Google Cloud Shell. The script exited 0 and all eight checks completed.

- A new interactive Bash shell resolved both the `r2md` alias and `/home/syliu/.local/bin/r2md`.
- A non-interactive Bash shell found the executable through PATH and converted a DOCX with spaces in its input and output paths.
- PATH, alias, and direct locked-Pixi invocation produced byte-identical Markdown for that DOCX.
- An existing output, a missing input, and using the DOCX source path as the output were rejected with status 2. The existing output was not changed.
- The Git PPTX converted through the wrapper to a 779-line, 31,752-byte Markdown file and printed the expected format-specific review message.
- All six original input hashes and the Pixi lockfile remained unchanged.

The project skill was installed at `.agents/skills/research-to-markdown/SKILL.md` in Cloud Shell. The log reported that `codex` was absent from PATH, so no live agent skill test occurred.

The returned manifest and lockfile hashes match the earlier six-file conversion run. The wrapper and skill contents match the prepared local versions. The actual Cloud Shell lockfile is now retained at the local project root, with the supplied evidence snapshot under `runs/`.

These checks demonstrate the CLI in Cloud Shell, including a new interactive shell and a non-interactive shell with configured PATH. They do not establish execution on an HPC compute node or successful skill selection by an agent.
