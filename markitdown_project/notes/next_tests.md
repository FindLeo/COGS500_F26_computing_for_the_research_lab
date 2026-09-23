# Reproduce the command and skill tests in Cloud Shell

Status update: these CLI checks and the explicit live skill test have now completed successfully. The instructions below are retained for reproduction. See `cli_evaluation.md` and `skill_evaluation.md`.

From the project directory, with Pixi installed and the six sample files placed in `inputs/`, run:

```bash
pixi install --locked --manifest-path pixi.toml
bash shell/install_and_test.sh
```

The script installs a link at `~/.local/bin/r2md`, copies the skill into the project's `.agents/skills/research-to-markdown/`, and adds a source line to `~/.bashrc` for `shell/env.sh`. An unrelated existing executable or different installed skill is not replaced. It tests direct, PATH, and alias invocation, handling paths with spaces, source preservation, and refusal to overwrite existing output. It exports one log and a small evidence ZIP containing the log, `pixi.toml`, and `pixi.lock` to the home directory for transfer.

The installer refuses to replace an unrelated `~/.local/bin/r2md` link or a different installed skill. In the current terminal after setup, run:

```bash
export R2MD_PROJECT_DIR="$PWD"
source shell/env.sh
```

For an HPC batch job, install Pixi and the locked project under your account, install the wrapper, and source `shell/env.sh` in the job script. The command requires no root access. Cluster policies, network availability during installation, CPU/platform support, and runtime filesystem access still require validation on the actual cluster. Cloud Shell is the tested Linux environment so far.

## Reproduce the explicit live skill test

The shell checks validate the command; `skill_evaluation.md` records the completed explicit Codex test. With Codex installed and authenticated in a similar environment, run `bash shell/run_skill_test.sh` from the project directory. The script captures the prompt, structured event stream, final answer, hashes, and converted file in one evidence archive. Its prompt asks the agent to use the skill to explain slides 20 and 53 of the Git deck. The equivalent interactive request is:

> Use $research-to-markdown to read inputs/git_slides.pptx. Create a new Markdown copy under outputs/skill-test/, explain the working-tree/staging/commit relationship on slide 20, and report what you can and cannot determine about the screenshots on slide 53.

Check that the agent converted before reading the Markdown, distinguished source alt text from visible image content, and acknowledged missing images. The project has one successful explicit invocation, but implicit selection remains untested. No LLM run is launched by `install_and_test.sh`.

Skill discovery and invocation are documented in [OpenAI's Build skills guide](https://learn.chatgpt.com/docs/build-skills). Conversion is performed after the agent receives the prompt; a skill is not a pre-upload file converter.
