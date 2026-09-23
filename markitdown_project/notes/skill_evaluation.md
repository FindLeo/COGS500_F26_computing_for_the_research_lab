# Live Codex skill evaluation

Evidence supplied by the student: `runs/skill_20260923T025916Z/`. Codex CLI 0.156.0 ran in Google Cloud Shell on 2026-09-23 UTC. The harness and agent process exited successfully.

The explicit `$research-to-markdown` prompt asked about slides 20 and 53 of the Git deck and required a fresh conversion. The recorded sequence shows the agent reading the installed skill, invoking the installed `r2md` wrapper, reading the new Markdown, and inspecting source PowerPoint XML and extracting source images. It did not read previous evaluation notes or conversion outputs. The new Markdown is byte-identical to the earlier 31,752-byte Git conversion (SHA-256 `bd7d01e9252e3d683337a7fb6786d1022351e895a231ad040f6c386b80e6776e`). All six source files, the lockfile, wrapper, and skill stayed unchanged.

The final answer correctly explained working tree → add → staging area → commit → local repository. It distinguished the converted screenshot alt text from details available in the original images, identified a merged pull request and an open issue, and explained missing relative image targets and cropping limitations. Independent review of the source images supports these details.

The final answer says it visually inspected extracted images. The supplied event stream records extraction and source XML inspection but has no separate image-view event; the trace alone does not verify that particular action. This distinction should remain in any detailed audit.

This verifies one explicit skill invocation. Implicit skill selection, other AI agents, local models, actual HPC execution, and repeated-run reliability were not tested. A skill runs after the prompt reaches the agent; it is not a pre-upload conversion hook.
