---
name: code-style
description: The user's code style. Load before writing or reviewing code in any language or project, and before proposing a refactor, a test plan, or an API shape.
---

# Code style

How this user wants code written and reviewed. Language-agnostic unless a rule says otherwise.

**Precedence.** A project's existing conventions win over anything here. Match the surrounding file
first, then apply these. Where a language has a canonical formatter or idiom, follow it unless the
repo has visibly chosen otherwise, and check which before assuming.

## Comments

- A comment explains what the code cannot. Skip it when the line already says the same thing.
- Run the `unslop` skill before writing one. Short comments are where the tells hide, because there
  is no room to notice them.
- Write the file as if it had always been this way. No notes about what moved, what was removed, or
  what is deliberately absent. Version control holds that.
- Put the comment next to what it describes. An error branch does not explain where its value came
  from, and a call site does not narrate the function it calls.
- Document a value where it is declared. A type or constant is the first place someone looks it up,
  so stating the meaning there is worth repeating even when a consumer also explains it.
- Say why, not what. Why a column list omits a field, why a field is nullable, why a query does not
  poll.
- Assume a competent reader with an editor that can jump to a definition. Do not narrate a trail
  they can follow themselves.

## Assumptions

- Never assume how a dependency behaves. Read its source or docs before building a workaround
  around it.
- Do not probe a library with a throwaway test. Reading it is faster and leaves nothing behind to
  maintain.
- Record what you looked up so it is not re-derived later. Cite file and line where it explains a
  decision.
- Confirm state against the running system or database instead of inferring it from code.
- Prove a suspected defect before designing around it.
- Verify a diagnostic before repeating it. Editor and language-server state goes stale.

## Reach for what already exists

- Write it, then look again for what to simplify. Nothing becomes reusable before it has a second
  caller.
- Search for the function before writing it.
- Check whether the framework already does it. Hand-rolled parsing, validation and state juggling
  is usually a feature nobody read about yet.
- No one-line wrappers, single-caller helpers, or util grab bags. Inline by default, and prefer a
  shape that needs no helper.
- Do not import a module for one value it happens to expose. Use the primitive, or read it at the
  composition point.
- A new dependency needs a go-ahead. Only suggest one that removes more than it adds.
- Unused-looking code is often a planned feature. Fields, enum values and parameters that never vary
  stay. A stub returning success is a bug.

## Naming and layout

- Name a file for the broad category, not the narrow case. Move same-category functions in while you
  are there.
- Collapse near-identical config blocks with a conditional. Stop where a genuinely per-case field
  appears.

## Tests

- Every test names a failure that could actually happen.
- Test what fails quietly. Skip what breaks on the first page load, because nobody ships past it.
- Never test a dependency's own behaviour. Test the code here that leans on it.
- No change detectors, no near-duplicates. Extend the existing assertion instead.
- Each phase of a plan ends with the tests that verify it, not one manual pass at the end.
- State what you left untested, and why.

## API design

- Assume the caller is curl holding a valid token. A role check is a floor, not a gate, and a page
  the UI hides stops nobody.
- Scope ownership inside the query. Put the owner in the WHERE clause rather than loading a row and
  comparing afterwards.
- Time windows gate writes, not reads. Someone should still see what they submitted after a
  deadline.
- A discovery endpoint answers in every state and reveals almost nothing while hidden.
- Take a set rather than making the client loop.
- One function per endpoint. Share transport and error typing, never the query hook.
- Update the saved API requests when a contract changes, refusals included.

## Data and persistence

- Never `SELECT *`.
- One row is a column or a singleton, not a table.
- Name every column you read. It keeps large values out of small queries.
- Fix bad data at the producer. Do not teach the consumer to tolerate it.
- Model optionality with a nullable type, not by re-parsing a raw string.
- Derive state from the field carrying the verdict. Free text drifts.
- Know how schema changes reach each environment before writing one. A build script that only ever
  creates will not migrate anything.
- Guards run before the write, not after.

## Frontend

- Avoid data-driven abstraction for a small fixed set.
- Let the framework reset state. Key a component instead of syncing props into state with an effect.
- Build for phone and tablet, not the projector.
- Label chart axes with what they hold.
- Do not couple a component to a module it shares nothing with.

## Planning and scope

- A phase describes its own work, not a diff against what shipped.
- Finished work becomes context, not a numbered step.
- Stay inside the branch. Adjacent cleanup goes in its own change.

## Project mechanics to check, never assume

These vary per repo and are worth confirming rather than inferring:

- Whether the repo is formatted by the language's canonical tool, and its indent width.
- Which test flags the build can support.
- Whether commits and tags are yours to make. Default to leaving work in the tree.
- Whether a remote API or wiki is read-only.
- Which inputs are trusted, so an audit does not report them as findings.

## One meta-rule

A narrow instruction is not a general rule. When a situational "don't do this here" hardens into
"never do this," it starts deleting work that was fine. If a rule above is cutting something
reasonable, it is drawn too wide.
