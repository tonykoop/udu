# Handoff: Model an Udu drum in Blender (V5 pipeline pilot)

## Who you are

You are Claude Desktop with Blender MCP. You're picking up the V5 build-packet work for the Udu drum repo. This handoff is self-contained — you don't have prior conversation context.

## Background

Udu is a Nigerian Igbo clay pot drum. The acoustically important features:
- A hollow body — egg/gourd profile, axially symmetric (a revolve of a 2D profile around the vertical axis)
- A **top neck** (spout) — open cylinder, the primary tone hole
- A **side hole** (ihota) — circular opening cut into the body wall, hand-modulated for pitch bend
- Walls of nominal 8–12 mm clay thickness

Frank Giorgini's modern udu family has named variants (Udongo, Hadgini, Tambuta, Mbwata) that differ in proportion. Aim for **Hadgini** (tall-narrow form) as the first model — it's the most recognizable silhouette.

Reference exemplar style: photoreal studio product photo, dark reddish-brown clay finish with a subtle hand-textured surface, slight specular highlight, soft warm key light, dark wood surface, shallow depth of field. Think Smithsonian catalog or Frank Giorgini's own photography.

## Where files live

Working directory on the host: `C:\Users\Tony\Documents\GitHub\udu\` (WSL: `/mnt/c/Users/Tony/Documents/GitHub/udu/`).

Create these subfolders if missing: `cad/`, `images/`, `images/blender-scenes/`, `images/material-study/`.

## Geometry (starter values — refine as you go)

For the Hadgini variant:

| Parameter | Value | Notes |
|-----------|-------|-------|
| `body_height_mm` | 330 | floor of body to start of neck |
| `body_max_diameter_mm` | 220 | widest point, ~45% up from base |
| `body_max_dia_height_frac` | 0.45 | fraction of body height at widest point |
| `base_diameter_mm` | 110 | flat-ish bottom for stability |
| `shoulder_diameter_mm` | 140 | where neck meets body |
| `neck_height_mm` | 80 | open cylinder above shoulder |
| `neck_id_mm` | 55 | inner diameter of mouth |
| `neck_od_mm` | 75 | outer diameter — wall is 10 mm |
| `wall_thickness_mm` | 10 | uniform clay wall |
| `side_hole_diameter_mm` | 65 | the ihota |
| `side_hole_height_mm` | 200 | center of side hole, measured from base |
| `side_hole_angle_deg` | 0 | facing camera in default 3/4 view |

These are starter values consistent with Hadgini-class proportions; treat the design-table at `C:\Users\Tony\Documents\GitHub\udu\udu-design-table.xlsx` as authoritative if it exists, otherwise propose these as the seed.

## Tasks (in order)

### 1. Build the parametric model in Blender

- Create a 2D profile curve in the XZ plane traced through the points above (base → max-diameter → shoulder).  
  Smooth it with a Bezier spline; the silhouette should be a clean teardrop, not a kink.
- Use **Spin** (or a Screw modifier with 360° and steps=64) to revolve the profile around the Z axis. Result: a closed shell, no top, no bottom.
- **Solidify** with thickness = `wall_thickness_mm` (10 mm, offset = -1 so thickness grows inward from the visible surface).
- Add the **top neck**: cylinder, OD 75, ID 55, height 80, sitting on the shoulder, booleaned-union with the body.
- Add the **side hole**: a cylinder of OD ≥ wall thickness × 2, passing through the body wall at the height/angle above, then **Boolean Difference** from the body. The hole should be cleanly punched, no fragmented faces.
- Verify the inside is hollow (cutaway view through Solidify); no internal walls.

Save the .blend file to `images/blender-scenes/udu-hadgini-master.blend`.

### 2. Render the hero shot

- 2048 × 1536, sRGB, Cycles or Eevee (state which).
- Camera: 3/4 view, slightly below shoulder height, looking at the side hole.
- Lighting: HDRI studio environment + a soft warm key light from camera-left.
- Material: PrincipledBSDF with `Base Color` ≈ #5a3225 (dark reddish clay), `Roughness` 0.7, slight `Bump` from a Voronoi or Musgrave noise to simulate hand-burnished clay surface.
- Floor: dark walnut wood with subtle reflection.

Save the render to `images/hero-render.png`.

### 3. Render the exploded diagram

- Same camera and lighting.
- Translate the **neck** straight up by ~120 mm.
- Translate the **side-hole cylinder** (or its negative as a labeled component) outward along its axis by ~80 mm to show it as a separate "removed" piece.
- Save to `images/exploded-diagram.png`.

(Numbered callouts can be added in Photoshop later via the Adobe MCP pipeline — don't do that in Blender.)

### 4. Material study

Re-render the hero camera/lighting with three clay variants. Save as:
- `images/material-study/clay-dark.png` — base #5a3225 (Hadgini)
- `images/material-study/clay-terracotta.png` — base #b85c3a (lighter Tambuta look)
- `images/material-study/clay-black-burnished.png` — base #1f1818, roughness 0.4 (high-fired smoke finish)

Same camera, same lighting — only the material changes.

### 5. Write the provenance log

Create / append to `cad/mcp-session-log.md` with this header if missing:

```
| timestamp | tool | artifact | session_id | parent_artifact | notes |
|-----------|------|----------|------------|------------------|-------|
```

Add a row for each file you produced. Use ISO-8601 UTC for `timestamp`, `blender` for `tool`, your Claude Desktop conversation ID if exposed (else `unknown`) for `session_id`, and the upstream file for `parent_artifact` (e.g., parent of `hero-render.png` is `images/blender-scenes/udu-hadgini-master.blend`).

### 6. Update the visual-output register

If `visual-output-register.csv` doesn't exist, create it with this header:

```
artifact_id,path,artifact_kind,role,authority,dimension_claim
```

Add a row for each rendered PNG with `artifact_kind=render_preview`, `role=concept`, `authority=non_fabrication`, `dimension_claim=non_authoritative`. Add one row for the .blend file with `artifact_kind=cad`, `role=fabrication_geometry`, `authority=fabrication`, `dimension_claim=traceable_to_design_table` *only if* you sourced the geometry from `udu-design-table.xlsx`; otherwise mark it `dimension_claim=seed_values`.

## Acceptance gates

- [ ] `images/blender-scenes/udu-hadgini-master.blend` checked in, reopens cleanly
- [ ] `images/hero-render.png` exists, 2048×1536, recognizable as an udu drum
- [ ] `images/exploded-diagram.png` exists, neck + side-hole visibly separated
- [ ] `images/material-study/*.png` — three clay variants, same camera
- [ ] `cad/mcp-session-log.md` has one row per produced file
- [ ] `visual-output-register.csv` has matching rows
- [ ] No PNG marked as fabrication authority (these are concept-only)

## What to do if you get stuck

- If a Boolean Difference produces a fragmented hole, switch the body to "Solidify after the boolean" instead of before, or use the Knife Project workflow with a cylinder cap.
- If the silhouette looks too "vase-like" rather than "udu-like," reduce `shoulder_diameter_mm` to ~120 and ensure the curve has a clear narrowing between body-max and shoulder.
- If your Blender MCP session times out, save the .blend frequently and report which step you reached.

## Where this fits

- Repo issue: **tonykoop/udu#1** — Generate V5 build packet
- V5 spec: **tonykoop/instrument-maker#178**
- Blender pipeline contract: **tonykoop/instrument-maker#180**
- Provenance schema: **tonykoop/instrument-maker#183**

When done, comment on **tonykoop/udu#1** with the produced file list and a thumbnail of the hero render.
