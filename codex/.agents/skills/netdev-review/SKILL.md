---
name: netdev-review
description: Analyze Linux netdev mailing-list patches and recommend the five best review opportunities based on technical interests, learning value, and potential upstream contribution.
---

# Netdev Patch Review Curator

## Objective

Find and rank the five best Linux kernel patches or patch series for me to review from my Gmail `netdev` label.

The goal is to develop deep Linux kernel networking expertise while making useful upstream contributions.

Do not simply recommend the newest, easiest, or smallest patches.

## Developer Profile

- C/C++ systems software engineer working professionally on embedded systems.
- Developing expertise in Linux kernel networking, device drivers, and kernel internals.
- Particularly interested in netdev, NIC drivers, NAPI, DMA, interrupts, sockets, qdisc, rtnetlink, concurrency, locking, and RCU.
- Has experience studying and reviewing upstream patches.
- Working on an independent E1000 toy driver.
- Wants to become a technically strong upstream contributor.

All recommendations must concern independent OSS work, not employer-owned code.

## Discovery

1. Use the connected Gmail integration.
2. Search messages with `label:netdev`, prioritizing the past seven days.
3. Identify actual patches using subjects such as `[PATCH]`, `[PATCH net]`, and `[PATCH net-next]`.
4. Group messages belonging to the same patch series.
5. Retrieve associated discussions and review replies.
6. Deduplicate revisions of the same series, preferring the newest revision.
7. Consider both individual patches and complete patch series.

If fewer than five suitable candidates exist, expand the search to 14 days.

Do not invent patches, discussions, review activity, or Message-IDs.

## Evaluation Criteria

Evaluate each candidate on:

### Technical relevance
Prefer work involving:
- NIC drivers and network device infrastructure
- Networking core
- NAPI, DMA, and interrupts
- qdisc and traffic control
- rtnetlink and netlink interfaces
- Socket and packet-processing internals
- Synchronization, locking, RCU, and lifetime management

Deprioritize tangential subsystems unless there is substantial networking relevance.

### Learning value
Prefer patches that require understanding meaningful kernel mechanisms, state transitions, invariants, concurrency, or hardware/software interactions.

### Review opportunity
Consider:
- Whether substantive reviews already exist
- Whether technical questions remain unanswered
- Whether the patch introduces nontrivial correctness concerns
- Whether an independent reviewer could provide meaningful value

Do not equate a lack of replies with a lack of review.

### Scope and effort
Favor patches that can reasonably be understood and reviewed thoroughly.

Small patches are not automatically better. Large series are acceptable when the architectural learning value justifies the effort.

Estimate effort conservatively.

### Upstream contribution potential
Prefer opportunities where careful technical review could reveal correctness issues, improve the implementation, or lead to follow-up contributions.

Do not claim that bugs exist without evidence.

## Research

For promising candidates:

1. Read the commit message and relevant discussion.
2. Inspect the diff when available.
3. Identify the subsystem and affected files.
4. Check whether a newer revision supersedes the candidate.
5. Check whether the patch has already been accepted or merged when possible.
6. Identify the specific kernel mechanisms that would need investigation.

Use lore.kernel.org and publicly available kernel sources to supplement Gmail when necessary.

Clearly distinguish verified facts from inferences.

## Ranking

Select exactly five candidates when sufficient suitable patches exist.

Rank them by overall value, considering:
- Technical relevance
- Learning depth
- Opportunity for meaningful review
- Manageable scope
- Contribution potential

Avoid selecting five nearly identical patches unless they genuinely dominate the alternatives.

## Output

For each recommendation provide:

1. **Rank and patch title**
2. **Author and submission date**
3. **Lore link**
4. **Message-ID** usable with `b4`
5. **Patch size** — files changed, approximate lines changed, and series length when available
6. **Existing review activity** — reviewers, comments, outstanding objections
7. **Why this is worth reviewing**
8. **Technical concepts involved**
9. **Estimated review effort**
10. **Potential review angles** — concrete mechanisms or invariants worth investigating, without presuming defects

Conclude with:
- The single best patch to start with and why
- A short comparison explaining why the top five outrank the other candidates

## Rules

- Do not prioritize patches merely because they are easy to understand.
- Do not recommend unrelated subsystems for superficial networking relevance.
- Do not recommend superseded patches without explicitly saying so.
- Do not mistake patch-series cover letters for individual code changes.
- Do not present speculation as a verified bug.
- Do not send emails or publish reviews.
- Do not modify my local repositories.
- Never generate `Reviewed-by` tags on my behalf.
- Be skeptical and technically precise.
- Prioritize engineering depth and usefulness over superficial activity.
