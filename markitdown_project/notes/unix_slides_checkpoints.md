# Unix PowerPoint checkpoints selected before conversion

Source: `inputs/unix_slides.pptx`, 22-slide University of Melbourne Bioinformatics introductory Unix workshop. Codex inspected the original slide text and rendered slides 8, 11, 17, and 20 on 2026-09-22 before seeing any MarkItDown conversion. This archived workshop is a conversion sample.

## Five factual details

1. Slide 3 says the workshop is split into eight sections.
2. Slide 5 states the Unix philosophy: do one thing and do it well, then use simple tools together for complex tasks.
3. Slide 12 shows `/home/user1/muscle.fq` as an absolute path.
4. Slide 14 says `pwd` prints the full path of the current working directory.
5. Slide 17 maps `/` to root, `~` to home, `.` to current working directory, and `..` to the parent directory.

## Three structural features

1. Slide boundaries and titles remain identifiable, so content from separate slides is not merged without context.
2. The slide 11 file-system diagram preserves relationships: root `/` contains `home/` and `settings`; `home/` contains `user1/` and `user2/`; `user1/` contains `muscle.fq`.
3. The slide 20 remote-login diagram preserves the relationship `Local computer` → `Network` → `High performance computing system`, including direction. The words alone are not enough if the direction or connection is lost.

Describe preservation, alteration, or loss; do not assign a numeric score. Diagrams may be represented textually in Markdown, but their relationships must be clear to count as preserved.
