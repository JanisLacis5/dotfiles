---
name: netdev-review
description: Analyze Linux netdev mailing-list patches and recommend five overall review opportunities plus five networking-core-only opportunities, prioritizing under-reviewed, QEMU-testable work with meaningful upstream contribution potential.
---

# Netdev Patch Review Curator

## Objective

Find and rank the best Linux kernel patches or patch series for me to review from my Gmail `netdev` label.

Produce two separate rankings:

1. **Top 5 overall** — the best review opportunities across Linux networking, including drivers and networking infrastructure.
2. **Top 5 networking core** — patches specifically involving the networking stack and core infrastructure, excluding device drivers.

The goal is to develop deep Linux kernel networking expertise while making useful upstream contributions.

Prioritize patches where I have a realistic opportunity to contribute meaningful technical review, rather than work that has already received extensive attention from experienced maintainers.

Do not simply recommend the newest, easiest, or smallest patches.

## Developer Profile

- C/C++ systems software engineer working professionally on embedded systems.
- Developing expertise in Linux kernel networking, device drivers, and kernel internals.
- Particularly interested in netdev, NIC drivers, NAPI, DMA, interrupts, sockets, qdisc, rtnetlink, concurrency, locking, and RCU.
- Has experience studying and reviewing upstream patches.
- Working on an independent E1000 toy driver.
- Wants to become a technically strong upstream contributor.

All recommendations must concern independent OSS work, not employer-owned code.

## Available Testing Hardware

Maintain the following inventory as an expandable list.

### Current inventory

- **QEMU** — Linux virtual machines with configurable virtual hardware, networking backends, and virtual NICs.

### Future hardware

None currently. Additional devices will be added to this list as they become available.

### Testing requirements

**Only recommend patches whose relevant behavior can be tested using the currently available inventory.**

For now, this means QEMU-based testing without any physical networking hardware.

Eligible testing mechanisms include:

- QEMU-emulated network devices, including E1000 and other supported virtual NICs.
- Virtual networking interfaces such as veth, dummy, and loopback.
- Network namespaces.
- TUN/TAP devices.
- Traffic control, qdiscs, and packet generators.
- Kernel networking selftests.
- KUnit and other relevant kernel test infrastructure.
- Packet captures, tracing, fault injection, and stress testing.
- Multiple QEMU guests connected through virtual networking.

Do not recommend patches requiring physical NICs, switches, PHYs, specialized offloads, or other unavailable hardware.

For driver patches, verify that QEMU actually emulates the relevant device and the specific behavior being changed. Merely emulating a device with the same name is not sufficient.

A patch is not eligible simply because it compiles or boots in QEMU. Its changed behavior must be meaningfully exercisable.

Distinguish between the ability to exercise the changed behavior and the ability to exhaustively prove correctness. Do not claim comprehensive validation when only partial coverage is possible.

For every candidate, identify a specific and realistic QEMU-based testing approach.

If the patch cannot be adequately tested using the inventory, exclude it.

## Discovery

1. Use the connected Gmail integration.
2. Search messages with `label:netdev`, prioritizing the past seven days.
3. Identify actual patches using subjects such as `[PATCH]`, `[PATCH net]`, and `[PATCH net-next]`.
4. Group messages belonging to the same patch series.
5. Retrieve associated discussions and review replies.
6. Deduplicate revisions of the same series, preferring the newest revision.
7. Consider both individual patches and complete patch series.
8. Identify the authors and existing review activity before investing in deeper research.
9. Apply the eligibility filters before ranking candidates.

If fewer than ten suitable distinct candidates exist, expand the search to 14 days, then to 30 days if necessary.

Do not invent patches, discussions, review activity, or Message-IDs.

## Eligibility Filters

Apply these filters before evaluating learning value or ranking.

### 1. Avoid already-reviewed patches

Exclude patches or series that have already received multiple substantive independent technical reviews.

In particular:

- Exclude patches where two or more independent reviewers have already performed meaningful technical reviews.
- Exclude patches where the main correctness or design questions have already been thoroughly investigated.
- Avoid series with substantial ongoing maintainer discussions where another reviewer is unlikely to add meaningful value.
- Prefer patches with zero or one substantive technical review, provided they have a legitimate review opportunity.

Distinguish between:

- Automated CI or bot responses.
- Acknowledgments and administrative replies.
- Questions from the author.
- Substantive technical reviews.
- Multiple replies forming a single review discussion.

Do not count every email reply as an independent review.

A patch with no responses is not necessarily a good opportunity. Evaluate whether the patch actually deserves technical investigation.

Review activity must be checked across available revisions, not just the latest message.

If review information is incomplete, explicitly state that rather than treating the patch as unreviewed.

### 2. Avoid patches from major established maintainers

Exclude patches authored by highly established, prominent Linux networking maintainers or developers who routinely drive major subsystem development.

The intention is to find opportunities where an independent, less-established contributor can realistically provide useful technical feedback.

Prefer patches from:

- New or less-established kernel contributors.
- Developers with relatively limited prior networking contributions.
- Occasional contributors submitting meaningful changes.
- Contributors whose patches have not already attracted significant maintainer attention.

Do not infer maintainer status from email domains, employer names, or the apparent complexity of a patch.

Use publicly available maintainer records and contribution history when needed.

A respected or experienced author is not automatically a major maintainer. Apply the exclusion to genuinely prominent, established subsystem figures rather than arbitrarily rejecting competent contributors.

### 3. Require practical QEMU-based testing

Every recommendation must have a feasible testing approach using the current hardware inventory.

Reject candidates where:

- The relevant behavior requires unavailable physical hardware.
- The feature depends on unsupported device functionality.
- QEMU cannot meaningfully exercise the changed path.
- Only compilation or unrelated smoke tests are possible.
- Testing depends on hardware-specific behavior that QEMU does not implement.

Prefer candidates that permit targeted regression tests, reproduction of failure conditions, and validation of important invariants.

### 4. Require meaningful networking relevance

Avoid patches primarily concerning unrelated subsystems.

For the networking-core ranking, exclude drivers regardless of whether they are virtual or physical.

## Evaluation Criteria

Evaluate every eligible candidate on the following dimensions.

### Technical relevance

Prefer work involving:

- Networking core and network device infrastructure.
- NIC drivers, NAPI, DMA, and interrupts (overall ranking only where applicable).
- qdisc and traffic control.
- rtnetlink and netlink interfaces.
- Socket and packet-processing internals.
- TCP/IP and other networking protocols.
- Synchronization, locking, RCU, and lifetime management.
- Packet ownership and memory management.
- Networking performance and scalability.

Deprioritize tangential subsystems unless there is substantial networking relevance.

### Learning value

Prefer patches requiring understanding of meaningful kernel mechanisms, state transitions, invariants, concurrency, or hardware/software interactions.

Favor work that builds transferable knowledge of the Linux networking stack rather than isolated implementation details.

### Review opportunity

Consider:

- Whether substantive reviews already exist.
- Whether technical questions remain unanswered.
- Whether the patch introduces nontrivial correctness concerns.
- Whether an independent reviewer could provide meaningful value.
- Whether testing could reveal issues not covered by existing reviews.
- Whether the author is likely to benefit from additional independent feedback.

Prioritize genuine opportunities to contribute, not merely opportunities to send an email.

### Testability

Consider:

- Whether the affected code path is accessible in QEMU.
- Whether the relevant conditions can be reproduced.
- Whether focused regression tests can be constructed.
- Whether relevant selftests already exist.
- Whether tracing or instrumentation can verify the affected behavior.
- Whether concurrency and failure paths can be exercised.

**Testability is a mandatory eligibility requirement, not merely a ranking bonus.**

### Scope and effort

Favor patches that can reasonably be understood, reviewed, and tested thoroughly.

Small patches are not automatically better. Large series are acceptable when their architectural learning value justifies the effort.

Estimate effort conservatively, including source investigation, testing, and review preparation.

### Upstream contribution potential

Prefer opportunities where careful technical review could reveal correctness issues, improve implementation quality, or lead to follow-up contributions.

Do not claim that bugs exist without evidence.

## Networking Core Classification

The second ranking must contain five patches specifically involving Linux networking core code.

Eligible areas include:

- `net/core/`
- `net/sched/`
- `net/ipv4/`
- `net/ipv6/`
- `net/netlink/`
- `net/socket.c`
- Other networking-core protocol or infrastructure code where appropriate.

Relevant topics include socket handling, packet processing, skb lifetime, qdisc behavior, netlink interfaces, protocol state, synchronization, and network namespace management.

**Exclude all device driver patches from this ranking**, including:

- Physical NIC drivers.
- Virtual network drivers.
- TUN/TAP driver changes.
- Driver-specific NAPI implementations.
- Changes primarily affecting `drivers/net/`.

The distinction should be based on which subsystem owns the changed behavior, not merely the patch subject.

Patches changing generic networking-core infrastructure are eligible even if that infrastructure is used by drivers, provided the change itself is not driver-specific.

## Research

For promising candidates:

1. Read the commit message and relevant discussion.
2. Inspect the complete diff, not only the cover letter.
3. Identify the subsystem and affected files.
4. Check whether a newer revision supersedes the candidate.
5. Check whether the patch has already been accepted or merged when possible.
6. Investigate the author's maintainer status and relevant contribution history.
7. Determine the number of substantive independent reviews.
8. Identify the specific kernel mechanisms requiring investigation.
9. Verify that the relevant behavior can be tested using the available hardware inventory.
10. Develop a concrete initial testing strategy.

Use lore.kernel.org and publicly available kernel sources to supplement Gmail when necessary.

Consult relevant kernel source, call sites, existing tests, and subsystem documentation to verify assumptions.

Clearly distinguish verified facts from inferences.

## Ranking

Produce two separate ranked groups.

### Ranking A — Top 5 Overall

Select the five strongest opportunities across all relevant Linux networking areas.

Include driver patches only when the affected behavior is adequately testable with QEMU.

Rank by:

1. Opportunity for meaningful independent review.
2. Technical relevance and learning depth.
3. Quality of the available testing approach.
4. Potential for upstream contribution.
5. Manageable review effort.

### Ranking B — Top 5 Networking Core

Select five opportunities specifically involving networking core code.

Apply the same eligibility and evaluation criteria, but exclude drivers entirely.

Prefer five distinct additional recommendations rather than repeating candidates from Ranking A.

If overlap is unavoidable because the eligible pool is limited, explicitly identify it. Do not fill the ranking with weaker or ineligible patches merely to reach ten.

If fewer than five eligible candidates exist in either category after expanding the search, return fewer and explain the limitation rather than relaxing the mandatory filters.

Avoid selecting nearly identical patches unless they genuinely dominate the alternatives.

## Output

Present the results in two clearly separated sections.

### A. Top 5 Overall

### B. Top 5 Networking Core

For each recommendation provide:

1. **Rank and patch title**
2. **Author and submission date**
3. **Lore link**
4. **Message-ID** usable with `b4`
5. **Patch size** — files changed, approximate lines changed, and series length when available
6. **Existing review activity** — independent technical reviewers, comments, outstanding objections, and review status
7. **Author background** — relevant contribution history and whether the author is an established subsystem maintainer
8. **Why this is worth reviewing**
9. **Technical concepts involved**
10. **Estimated review effort** — include source investigation and testing
11. **Potential review angles** — concrete mechanisms or invariants worth investigating, without presuming defects
12. **QEMU testing plan** — a realistic description of how to exercise the changed behavior using the available inventory
13. **Testing limitations** — what cannot be verified with the available environment, if anything relevant remains

Prioritize actionable technical information over lengthy descriptions of the patch's purpose.

Conclude with:

- The single best patch to start with across both rankings and why.
- A short comparison explaining why the strongest recommendations outrank other considered candidates.
- A brief explanation of any candidates rejected due to review saturation, major-maintainer authorship, or insufficient hardware testability.

## Rules

- Do not prioritize patches merely because they are easy to understand.
- Do not recommend unrelated subsystems for superficial networking relevance.
- Do not recommend superseded patches without explicitly saying so.
- Do not mistake patch-series cover letters for individual code changes.
- Do not present speculation as a verified bug.
- Do not recommend patches that have already received multiple substantive independent reviews.
- Do not recommend patches authored by major established networking maintainers.
- Do not recommend patches that cannot be meaningfully tested with the available hardware inventory.
- Do not include driver patches in the networking-core ranking.
- Do not assume QEMU accurately emulates hardware functionality without checking.
- Do not confuse a testable code path with comprehensive proof of correctness.
- Do not sacrifice quality or violate eligibility constraints to fill the rankings.
- Do not send emails or publish reviews.
- Do not modify my local repositories.
- Never generate `Reviewed-by` tags on my behalf.
- Be skeptical and technically precise.
- Prioritize engineering depth, practical testability, and meaningful upstream contribution over superficial activity.

