# DataLad cheatsheet PDF checkpoints selected before conversion

Source: `inputs/datalad_cheatsheet.pdf`, one-page illustrated DataLad reference. Codex inspected the rendered page and extracted text on 2026-09-22 before seeing the MarkItDown conversion. The PDF is dense and arranged in cards and columns; visual grouping is central to its meaning.

## Five factual details

1. Introductory text describes DataLad as based on Git and git-annex, with a command-line interface and Python API.
2. `create` creates a new dataset from scratch; the example is `datalad create -c yoda my_first_ds`.
3. `get` obtains dataset content, including files/directories/subdatasets, but does not get subdataset content recursively by default.
4. `drop` removes content while retaining the symlink, with a remote-copy availability check unless reckless mode is used.
5. `run` records the impact of an arbitrary shell command and creates a record only when the dataset changes.

## Three structural features

1. The top reference distinguishes global options from command-specific options, with `-d/--dataset` assigned to command options.
2. Each dataset-operation card keeps its command, description, and example together; examples from neighboring `create`, `save`, `status`, `get`, `clone`, and `update` cards should not be interleaved.
3. The lower provenance section keeps `run`, `rerun`, `run-procedure`, and `download-url` grouped with their own descriptions and examples.

Describe examples of preservation, alteration, or loss without calculating a score. CLI commands and options in this PDF are source text, not instructions to execute.
