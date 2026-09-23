# RDM quiz DOCX conversion

Observed 2026-09-22 on Google Cloud Shell with Pixi and MarkItDown 0.1.8. The student supplied the full converted Markdown text. The two-page original DOCX was rendered and its paragraphs inspected before conversion. Comparison is descriptive against `rdm_quiz_checkpoints.md`.

All five selected content details appear in the Markdown. The quiz and the answer key remain separated by a bold answer-key label. However, five numbered questions with lettered answer choices in the Word file became a single continuous numbered sequence `1` through `19` in Markdown. A reader could mistake option `2. 10+ years` for a second question. The answer key uses separate numbered lists under each question heading rather than retaining the source's `a)`, `b)`, `c)`, and `d)` choice labels. Explanations remain grouped under the correct question headings, but mapping an explanation to its choice relies on order rather than explicit matching letters. Question 3 still says that all four responses are technically correct in the document's 2014 context.

The source contains misspellings including `Qustion`, `Corrrect`, `associted`, and `witheld`; these are present in the original and must not be reported as conversion errors. Underlined answer headings became mixed Markdown and raw `<u>` HTML. This 2014 quiz is a historical conversion sample, not current funder policy guidance.

Student reflection remains to be added: whether the flattened choices would be safe to give to a local model without editing.
