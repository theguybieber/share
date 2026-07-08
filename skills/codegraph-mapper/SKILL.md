---
name: codegraph-mapper
description: This skill should be used when the user asks to "map dependencies", "check architectural impact", "trace the graph", or explore how a specific component connects to the rest of the system.
allowed-tools: codegraph_explore, codegraph_search, codegraph_callers, codegraph_callees
---
# Architectural Mapping Workflow

## Purpose
Before modifying core logic or rewriting structural interfaces, you must use the local CodeGraph to understand the exact dependencies and blast radius of the proposed changes.

## Process
When requested to map or refactor an architectural component, follow these exact steps:

1. **Do not use grep or file-read tools first.**
2. Invoke `codegraph_search` to locate the exact node ID of the target component (e.g., a Rust struct, trait, or function).
3. Use `codegraph_explore` on that node ID to get an immediate map of its incoming and outgoing edges.
4. If modifying a core function, use `codegraph_callers` to verify every upstream dependent that will be impacted by the change.
5. Once the architectural graph is understood, *then* use standard file reading tools to examine the specific implementation details.

## Output
Provide the user with a brief summary of the dependencies found via the graph before proceeding with any code generation or refactoring.
