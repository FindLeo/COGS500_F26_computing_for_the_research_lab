# Live Codex skill test

The CLI and alias checks passed in Cloud Shell; Codex CLI was not installed there at the time of those checks. This is a separate test of an agent following the skill, using the public Git presentation. It does not test an HPC-local model.

Install Codex in Cloud Shell using the [official CLI installation instructions](https://learn.chatgpt.com/docs/codex/cli), then sign in with `codex login --device-auth`. The [authentication guide](https://learn.chatgpt.com/docs/auth) describes enabling device-code login when needed and completing sign-in in your browser.

Upload `run_skill_test.sh` to the Cloud Shell home directory and run:

```bash
bash "$HOME/run_skill_test.sh"
```

The script invokes one Codex session with a fresh output path. It records the explicit skill prompt, version, JSON event stream, diagnostics, final answer, source/configuration hash checks, and generated Markdown. The evidence ZIP is written to the home directory. Authentication is completed separately and credentials are not included in the archive.

The prompt asks about slide 20 and slide 53 without providing the expected answer. Review whether the agent loaded the skill, invoked the wrapper, read its new output, preserved the originals, and supported its answer with the available evidence. An exit status of zero does not by itself demonstrate these behaviors. Explicit skill invocation is tested; automatic selection remains a separate behavior.

The script uses `codex exec --json --sandbox workspace-write`, an output message file, and stdin for the full prompt, as documented in [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode). The Git-repository check is skipped because the prepared course folder may not yet be a Git repository. The workspace sandbox remains enabled. If the environment blocks execution, retain the evidence and resolve the specific issue rather than treating the run as successful.
