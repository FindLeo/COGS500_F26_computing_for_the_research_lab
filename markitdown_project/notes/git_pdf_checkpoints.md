# Git cheatsheet PDF checkpoints selected before conversion

Source: `inputs/git_cheatsheet.pdf`, two-page GitHub Education PDF dated 2014 in its metadata. It is a historical conversion sample, not current Git installation guidance. Codex inspected both rendered pages on 2026-09-22 before seeing a MarkItDown conversion.

## Five factual details

1. Page 1: `git status` shows modified files in the working directory and what is staged for the next commit.
2. Page 1: `git add [file]` stages a file as it looks now for the next commit.
3. Page 1: `git reset [file]` unstages a file while retaining working-directory changes.
4. Page 2: `git remote add [alias] [url]` adds a Git URL as an alias.
5. Page 2: `git stash pop` writes work from the top of the stash stack.

## Three structural features

1. Major category labels remain identifiable, including `SETUP & INIT`, `BRANCH & MERGE`, `INSPECT & COMPARE`, and `SHARE & UPDATE`.
2. Each command stays adjacent to its own description, especially `git diff` versus `git diff --staged` on page 1.
3. The two-column layout does not scramble reading order by interleaving unrelated left- and right-column sections.

After conversion, describe preservation, alteration, or loss with quoted examples and line numbers. Do not assign numeric scores. The design uses shaded rows, not a semantic data table; do not require Markdown table syntax.
