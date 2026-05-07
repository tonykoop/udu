# UDU-000_MasterLayout — Sketch Hierarchy

The udu master sketch follows the v4.1 SW convention: the master sketch
sits on the Front plane and contains the *driving* dimensions for the
body envelope. Other sketches reference it via `Convert Entities` or
`Pierce` relations. This keeps the dependency graph clean and lets the
design table propagate changes through one root.

```
Sketch_Master_Profile (root, Front plane)
  ├─ body_diam_in          (driving Ø)
  ├─ body_height_in        (driving height)
  ├─ shape_factor           (controls ovoid pinch)
  └─ wall_thk_in            (offset for inner profile)
        │
        ├── Reference plane: Mouth_Plane (top of body, normal to revolve axis)
        │     │
        │     └── Sketch_Mouth_Port (pierces master, references mouth_diam_in)
        │
        ├── Reference plane: Side_Hole_Plane (mid-height, hand-comfort offset)
        │     │
        │     └── Sketch_Side_Port (pierces master, references side_diam_in)
        │
        └── Sketch_Inner_Profile (offset Sketch_Master_Profile by wall_thk_in)
              │
              └── (used to subtract chamber from solid revolve)
```

## Feature order

```
1. Sketch_Master_Profile          (master ovoid outline)
2. Revolve1                       (creates outer body solid)
3. Sketch_Inner_Profile           (offset inward for chamber)
4. Revolve2 (cut)                 (subtracts chamber → hollow body)
5. Sketch_Mouth_Port (extrude cut) (top opening)
6. Sketch_Side_Port (extrude cut)  (side hand-slap port)
7. Fillet1                        (rim radius ≥ 1/8" — see risks.md ERG-02)
8. Fillet2                        (side-hole edge radius)
```

## What NOT to do

- **No raw numeric dimensions** in any feature. Every dimension must
  reference a global (`body_diam_in`, `mouth_diam_in`, etc.) or an
  arithmetic combination of globals.
- **No sketches that bypass the master profile.** The mouth port and
  side port both `Pierce` `Sketch_Master_Profile`. If a new feature
  needs the ovoid outline, it references the master sketch — it does
  not redraw it.
- **No hand-tuned shrinkage compensation in the SW model.** The fired
  geometry is what's modeled. Master scaling is applied at STL export
  via `master_scale_factor` (a single multiplier on all dimensions),
  not by editing each dimension.
