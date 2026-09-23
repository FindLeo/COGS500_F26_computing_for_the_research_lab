# Experiment log

## 2026-09-22 — Preparation by Codex

1. Read the final project rubric and the existing proposal. The report must document actual experiments, difficulties, results, and the student's reflections rather than proposed results.
2. Confirmed Pixi 0.70.1 is already installed on the Mac.
3. Copied the two existing PDFs and proposal into `inputs/`; downloaded the three selected public source files. Verified PDF signatures and expected Office archive components. Recorded byte sizes and SHA-256 hashes.
4. Inspected the proposal's original DOCX text and paragraph styles. Selected five factual and three structural checkpoints before conversion. No original layout rendering has been assessed yet.
5. Prepared a Pixi manifest using Python 3.12 and the PDF, DOCX, and PPTX extras. Attempted `pixi install --manifest-path markitdown_project/pixi.toml`; it failed because the sandbox denied access to the local Pixi cache.
6. Requested permission to install with normal cache/network access; the request was declined. Installation remains incomplete. This is an execution-permission issue, not demonstrated evidence of a MarkItDown defect.
7. Prepared an interactive alias file and instructions, without changing shell startup files. The alias and conversion task still need execution tests after installation.

## Student reflection to add after the first experiment

Record what you expected, what you observed in the original and Markdown, what surprised you, and how the result changes your intended use of the software. No personal reflection has been supplied or inferred yet.

## 2026-09-22 — Cloud Shell setup reported by student

- Student chose Google Cloud Shell as the primary Linux workspace.
- Student reported `/home/syliu`, Linux x86-64, approximately 4.0 GB free on `/home`, and a successful official Pixi installation reporting version 0.81.0.
- Prepared a project archive for transfer. Cloud Shell file upload, project environment installation, and any conversions remain unverified.

## 2026-09-22 — First conversion reported by student

- Student reported that `pixi install` succeeded in Cloud Shell.
- Student supplied output from MarkItDown 0.1.8 after converting the proposal DOCX. The output was compared with the preselected source checkpoints; see `proposal_evaluation.md` for findings and the correction about the Word `Resource` style.
- The interactive alias, other formats, and Cloud Shell file persistence remain to be tested. The student's own reflection remains to be added.

## 2026-09-22 — Alias check reported by student

- Cloud Shell reported `r2md` as an alias for `pixi run --locked --manifest-path "$HOME/markitdown_project/pixi.toml" markitdown`.
- Student reported `cmp` found identical output between alias and direct invocation on the proposal DOCX. This verifies the interactive alias for that file in that session. Shell startup persistence and HPC execution remain untested.

## 2026-09-22 — Git cheatsheet PDF conversion reported by student

- Student supplied the full Markdown conversion of the two-page GitHub Education cheatsheet. All five preselected command/detail pairs have their text present, but the `git remote add` explanation is separated from its command by interleaved left-column content.
- Both PDF columns are interleaved in multiple places, and category labels are plain text rather than Markdown headings. See `git_pdf_evaluation.md` for examples.
- No student reflection about the PDF output has been recorded yet.

## 2026-09-22 — Unix PowerPoint conversion reported by student

- Student supplied the 428-line / 13,561-byte Markdown output from the 22-slide Unix deck.
- All five selected facts appear; slide boundaries and notes are present. File-system and remote-login diagram relationships are not fully represented in text. See `unix_slides_evaluation.md`.
- Student counted 111 image references, 33 unique relative targets, and 33 missing target files in Cloud Shell. The default Markdown output does not carry the diagram images. The student's personal reflection remains to be added.
- Student reran the PPTX conversion with `--keep-data-uris`. The output grew from 13,561 bytes with no embedded images to 4,406,444 bytes with 111 embedded image references. This changes image availability and file size, not the text-only description of the diagrams.

## 2026-09-22 — Research data management quiz DOCX conversion reported by student

- Student supplied full converted Markdown. Selected text survived, but the original five-question/lettered-choice hierarchy became a continuous numbered list of 19 items. The answer key remained distinct, though letter labels for matching answers were replaced by numbered items. See `rdm_quiz_evaluation.md`.
- Apparent spelling errors such as `Qustion` are in the original DOCX, not introduced by conversion.

## 2026-09-22 — DataLad cheatsheet PDF conversion reported by student

- Student supplied the converted Markdown of the one-page, dense, multi-card reference. The five preselected factual details appear in text, although neighboring cards interrupt some descriptions.
- Global versus command-specific options, command cards, and the provenance section lose their visual grouping. Generated tables contain empty columns and cross-card text. See `datalad_pdf_evaluation.md` for examples and limits.
- Student's own reflection is still pending.

## 2026-09-22 — Git slide deck pre-conversion inspection

- Inspected the original 66-slide PowerPoint and rendered slides 20 and 53. Slide 20 contains a working-tree → staging-area → local-repository diagram with `add` and `commit` arrows. Slide 53 contains two large remote-repository screenshots, with little native slide text beyond its title.
- Selected factual and structural checkpoints in `git_slides_checkpoints.md` before receiving any converted Markdown. Conversion and evaluation remain pending.

## 2026-09-22 — Consolidated run prepared

- At the student's request, prepared `shell/run_all_conversions.sh` to rerun all six files in a fixed order and create a timestamped log containing environment/version details, hashes, full command output, image-reference checks, and the complete default Markdown outputs. Existing conversions are not overwritten.
- Bash syntax check and a mock six-file run passed locally. The real Cloud Shell run and log transfer have not yet occurred.

## 2026-09-22 Arizona / 2026-09-23 UTC — Complete Cloud Shell log received

- Student supplied `markitdown_conversion_20260923T021223Z.log`. All six commands exited 0; total logged span was 11 seconds, including logging and environment checks.
- Imported the log and reconstructed all six outputs, verifying every output SHA-256 and confirming all input hashes match the local originals.
- Completed the Git slide deck evaluation: five facts and 66 slide markers survive, but diagram order, command formatting, and images have limitations. Existing screenshot alt descriptions survive; the images themselves are missing. See `git_slides_evaluation.md` and `conversion_results.md`.
- Cloud Shell lockfile contents, PATH command tests, and live Codex skill tests remain pending. The log alone records only the lockfile's hash.

## Next command and skill tests prepared locally

- Created `bin/r2md`, `shell/env.sh`, `shell/install_and_test.sh`, and `skills/research-to-markdown/SKILL.md`. The installation script will install the executable link, configure PATH and the alias, copy the project skill, and record focused tests in a single log. A transfer ZIP will include the real Cloud Shell lockfile with that log.
- Bash syntax checks and mocked wrapper tests passed, including filenames with spaces, source preservation, existing-output refusal, missing input, optional argument forwarding, converter error propagation, and a missing lockfile.
- The bundled skill validator could not start because PyYAML is absent in both available Python runtimes. Independently validated the YAML frontmatter using Ruby's YAML parser and reviewed the skill's scope and instructions. No live skill invocation has occurred.
- Consulted OpenAI's current skill guide: https://learn.chatgpt.com/docs/build-skills. The skill converts after an agent receives a prompt; it does not intercept file uploads before model input.

## 2026-09-22 Arizona / 2026-09-23 UTC — CLI evidence received

- Student supplied `markitdown_cli_20260923T022540Z.zip`. All eight Cloud Shell checks completed and the script exited 0; see `cli_evaluation.md`.
- The executable worked on PATH in a non-interactive shell, the alias persisted in a new interactive shell, and both produced the same DOCX output as direct Pixi invocation. Input hashes and the lockfile stayed unchanged.
- Verified the supplied manifest/lock hashes against the first conversion log and verified the returned wrapper and skill against the local files. Imported the exact Cloud Shell lockfile into the local project.
- Codex CLI was absent from PATH. Live skill execution remains pending; source conversion and shell integration tests are complete for this environment.

## Live skill test harness prepared

- Created `shell/run_skill_test.sh` to capture a single explicit Codex skill invocation with a fresh output path, full event stream, final answer, and source/configuration hash checks. The script exports evidence even when the Codex session fails.
- Bash syntax and mocked success/failure runs passed locally. The mocks validate logging and packaging only; they do not count as live agent tests.
- Verified installation, remote device-code authentication, and `codex exec` options against official OpenAI documentation. Actual installation/sign-in and live execution in Cloud Shell remain pending.

## 2026-09-22 Arizona / 2026-09-23 UTC — Live skill evidence and reflection

- Student supplied `markitdown_skill_20260923T025916Z.zip`. One explicit skill invocation completed with Codex CLI 0.156.0; see `skill_evaluation.md` for the event sequence and evidence limitations. Source/configuration hashes remained unchanged.
- Student reported learning deployment relevant to HPC and running a Codex skill, surprise at imperfect conversion, and intent to use the workflow cautiously. Actual testing was in Cloud Shell; actual HPC deployment is not established.
- Student confirmed the required project notebook has not been started. Notebook creation and instructor sharing remain outstanding.
