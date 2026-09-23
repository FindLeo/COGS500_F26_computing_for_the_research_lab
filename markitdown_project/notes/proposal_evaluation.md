# First conversion: project proposal DOCX

Observed 2026-09-22 on Google Cloud Shell (Linux x86-64), using Pixi 0.81.0 and MarkItDown 0.1.8. The student supplied the command output. Input: `inputs/project_proposal.docx`; output: `outputs/project_proposal.md`. The original DOCX was also inspected locally by text/style extraction and a two-page render. This is a descriptive comparison against the checkpoints in `proposal_checkpoints.md`, not a numeric score.

All five preselected factual details appear in the Markdown excerpt: the author's name/course/solo status; Pixi with PDF, DOCX, and PPTX; `r2md` expanded as research to Markdown; Cloud Shell as a Linux check without an HPC validation claim; and a six-file, two-per-format descriptive evaluation. The five section headings appear as Markdown `#` headings in the original order. All four numbered resource entries retain their names, destinations, and explanations. The title remains visually distinct from the italicized author line.

Two presentation changes matter for reuse: the Word `Title` paragraph became bold text rather than a Markdown heading, so a program relying on heading syntax may not identify it as the title; and underlined hyperlinks became Markdown links containing raw HTML `<u>` tags. The links remain readable, but the output is mixed Markdown and HTML. The source contained no tables or equations, so this conversion says nothing about those features.

Correction: `Resource` was the Word paragraph style name, not visible source text. Its absence from the Markdown is not a lost word. The numbered labels were preserved.

Student reflection is still needed: what you expected, what you found useful, what surprised you, and whether this changes how you would use the converted Markdown for local AI.
