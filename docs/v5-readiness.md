# Udu V5 Readiness Notes

Current status: V5 explorer/readiness packet, not a full V5 build-packet candidate.

The repo already has a strong v4.1 baseline: a parametric workbook, `family-spec.csv`, an OpenSCAD master-shape starter, SolidWorks import references, SVG previews, concept imagery, a print packet, and a risk register. Those artifacts are enough to orient a builder and reviewer, but not enough to claim production-ready geometry or measured acoustic validation.

## Evidence That Currently Controls Dimensions

| Evidence | Path | Current authority |
| --- | --- | --- |
| Parametric workbook | `udu-design-table.xlsx` | Design-table authority for current assumptions. |
| Family rows | `family-spec.csv` | Planning authority with measurement-required acoustic caveats. |
| OpenSCAD starter | `cad/udu_master.scad` | Fabrication-geometry starter derived from the workbook, not final production CAD. |
| SolidWorks design table | `cad/sw-design-table.xlsx` | Import-table authority limited to current v4.1 assumptions. |

## Remaining V5 Gates

| Gate | Status | Evidence needed |
| --- | --- | --- |
| Parametric CAD | Partial | Existing OpenSCAD starter needs measured shrinkage, fired volume, rim radius, foot/stand geometry, and per-size port corrections. |
| Vector design plates | Partial | SVG previews exist; DXF exports are not present and must not be implied. |
| Hero render | Partial | Existing hero image is concept-only, not a Blender render from exported CAD/STL. |
| Exploded diagram | Missing | Needs a generated or drawn component-offset diagram from the CAD authority chain. |
| AI artistic shots | Partial | Concept images exist and are registered as non-authoritative. |
| Annotated print plate | Missing | Needs an assembly plate whose callouts cite design-table cells. |
| MCP provenance log | Partial | `cad/mcp-session-log.md` currently records that no MCP sessions were run in this lane. |

## Vessel-Resonator Caveats

The workbook uses first-order dual-port Helmholtz predictions. Real udu behavior also depends on player hand impedance, partial port coverage, fired chamber volume, port-edge radius, wall thickness after shrinkage, and glaze firing. `family-spec.csv` therefore records the acoustic law as `unknown_requires_measurement` for the V5 validator until physical prototype measurements can replace the current assumptions.

Do not promote the repo to measured, validated, L2/L3/L4, or production-ready status until fired prototype measurements and CAD/DXF/design-table updates are present.
