# MCP Session Log

This repository has no recorded V5 MCP production sessions yet.

| timestamp_utc | tool | role | artifact | session_id | parent_artifact | authority | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-05-18T00:00:00Z | none | readiness_inventory | capstone-manifest.json | n/a | repository files | non_fabrication | Round 30 inventory only. No OpenSCAD MCP, Blender MCP, Illustrator MCP, Photoshop MCP, Adobe MCP, or image-gen-2 session was run in this lane. |
| 2026-05-18T00:00:00Z | none | readiness_inventory | explorer.html | n/a | repository files | non_fabrication | Explorer summarizes existing v4.1 evidence and remaining V5 gates. |
| 2026-07-01T00:00:00Z | claude-code (Fable 5) | packet_refresh | udu-design-table.xlsx | fable-v5-refresh-2026-07-01 | family-spec.csv | fabrication | V5 refresh provenance log-only pass: confirms visual-output-register.csv DT-001 authority=fabrication; no dimension changes made. No CAD/MCP tooling was run against this workbook in this session. |
| 2026-07-01T00:00:00Z | none (pre-existing, kept as-is) | packet_refresh | cad/udu_master.scad | fable-v5-refresh-2026-07-01 | udu-design-table.xlsx | fabrication | V5 refresh provenance log-only pass: confirms visual-output-register.csv CAD-001 authority=fabrication (pre-existing OpenSCAD master-shape starter, unchanged this pass — see cad/udu_master.scad header for its own authority caveat). |
| 2026-07-01T00:00:00Z | claude-code (Fable 5) | packet_refresh | cad/sw-design-table.xlsx | fable-v5-refresh-2026-07-01 | family-spec.csv | fabrication | V5 refresh provenance log-only pass: confirms visual-output-register.csv DT-002 authority=fabrication; no dimension changes made. |

Future V5 promotion must append one row per actual MCP session and artifact before claiming MCP provenance coverage.
