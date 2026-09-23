# DataLad cheatsheet PDF: qualitative evaluation

Source: `inputs/datalad_cheatsheet.pdf` (one page). Checkpoints were recorded in `datalad_pdf_checkpoints.md` before the conversion. Evaluation is based on the student's pasted Cloud Shell Markdown output on 2026-09-22; the output file itself has not been synced to the local project.

## Factual details

The introduction still states that DataLad is based on Git and git-annex and offers a command-line interface and Python API, although unrelated header words interrupt the sentence. `datalad create -c yoda my_first_ds` survives. The `get` description retains the distinction between obtaining a directory and not obtaining subdataset content recursively by default, but adjacent `clone` and `update` card text interrupts it. The `drop` description still says content is removed while its symlink is retained, and mentions remote-copy availability and `--reckless availability`. The `run` description still says it records the effect of a shell command only if the dataset changes. These details are present, but several require comparison with the original to recover their meaning confidently.

## Structure and use

The reference's visual grid is not preserved as usable Markdown. A wide, mostly empty Markdown table interleaves global and command-specific options, obscuring which options belong to which group; `-d/--dataset` is still visible. Dataset-operation cards are merged across columns: `create`, `save`, and `status` share a row; later `get`, `clone`, and `update` descriptions and examples cross one another. In the provenance section, `run`, `rerun`, `run-procedure`, and `download-url` are present, but lines from sibling/push cards intrude and final examples run together. The category headings remain plain text.

This file is useful for finding some keywords, but unsafe as a stand-alone command reference for a local text-only model. A user or agent should inspect the original PDF before using an option or pairing a command with an example. The source is a conversion benchmark, not a claim that its commands are current DataLad guidance.
