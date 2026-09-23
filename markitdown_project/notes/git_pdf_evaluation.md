# Git cheatsheet PDF conversion

Observed 2026-09-22 on Google Cloud Shell, using the Pixi MarkItDown 0.1.8 environment. The student supplied the full Markdown text from `outputs/git_cheatsheet.md`. The original two-page GitHub Education PDF was rendered and inspected locally before conversion. This is a descriptive comparison with `git_pdf_checkpoints.md`, not a numeric score.

The selected command strings and associated explanations are present in the output. In the `STAGE & SNAPSHOT` block, `git status`, `git add [file]`, and `git reset [file]` retain adjacent descriptions. `git stash pop` and its description are also adjacent. The `git remote add [alias] [url]` command and `add a git URL as an alias` explanation both survive, but they are separated by the left-column `git log` explanation.

The major category names remain readable, but they appear as plain text without Markdown heading markers. The two-column order is disrupted in both pages. For example, page 2 converts separate left and right columns into a sequence like:

```
git log
git remote add [alias] [url]
show the commit history for the currently active branch
add a git URL as an alias
```

A similar page 1 passage interleaves `git init`, `git merge [branch]`, and their descriptions. `git config --global color.ui auto` is placed after the `BRANCH & MERGE` label although it belongs to the left-column `SETUP` section. These changes can cause a model or human reader to attach explanations to the wrong commands.

The extracted text also contains Unicode ligatures such as `ﬁ` in `modiﬁed` and `ﬀ` in `diﬀ`. A plain-text search for the usual spelling may miss those words. Links are present. The source PDF is dated 2014 and is used to assess conversion fidelity, not as current Git installation guidance.

Observed limitation: having all words in the Markdown does not guarantee that the document's meaning survives. For command references or other multi-column PDFs, inspect command-description pairs and section order before using the conversion as context for local AI.

Student reflection still needed: whether this output would be trustworthy for the student's intended local AI use, and what checking or alternative they would use.
