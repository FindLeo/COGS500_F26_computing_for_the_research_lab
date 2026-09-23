# Six-file conversion results

Evidence: `runs/20260923T021223Z/full_conversion.log`, supplied by the student. Cloud Shell ran the six conversions using `pixi run --locked`, Pixi 0.81.0, and MarkItDown 0.1.8 on Linux x86-64. All six commands exited with status 0. The complete run spans 02:12:23–02:12:34 UTC on September 23, 2026 (September 22 in Arizona). The 11-second span includes logging and environment checks and is not an isolated performance benchmark.

| Source | Markdown bytes | Main observation |
| --- | ---: | --- |
| Proposal DOCX | 5,543 | Selected facts, headings, and links survive; title becomes bold and underlining uses HTML. |
| RDM quiz DOCX | 3,976 | Text survives; five questions with lettered choices become one numbered list. |
| Git cheatsheet PDF | 4,815 | Commands survive; columns interleave and some descriptions lose adjacency. |
| DataLad cheatsheet PDF | 11,400 | Selected facts remain; neighboring cards and option groups interleave severely. |
| Unix PPTX | 13,561 | Text and slide markers survive; diagrams lose relationships; all 33 relative image targets are missing. |
| Git PPTX | 31,752 | Selected facts and all 66 slide markers survive; diagram order and command formatting degrade; all 33 relative image targets are missing. Meaningful existing image alt text survives. |

The raw log was copied without editing. Each Markdown file was reconstructed from its complete logged content and verified against its recorded SHA-256. All six source hashes also match the project's local originals. The actual Cloud Shell `pixi.lock` was later supplied with CLI test evidence and retained in the local project; its hash matches this conversion run.

These are descriptive observations for six selected documents, not a general accuracy score. Successful execution and information fidelity must be reported separately. Google Cloud Shell demonstrates execution in this Linux environment; an actual HPC cluster remains untested. A later explicit Codex skill invocation succeeded; see `skill_evaluation.md`.

The student's earlier Unix `--keep-data-uris` experiment is separate from this default run: 111 embedded image references increased the Markdown from 13,561 to 4,406,444 bytes. Embedding the images does not itself make their contents interpretable to a text-only model.
