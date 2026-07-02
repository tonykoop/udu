# Design Intent — udu rev A

- Master CAD: `cad/udu_master.scad` (sha256: 3ec045b758e5cc83f53b8c541f76a32af287d74531ad54095fb4cc0465b52187), driven by `family-spec.csv` (sha256: 79fac1c96f1760c02ea0c0ca49da3dd99e11b8f3c57aff36c2de8a3d846eea4a)
- Function: Slip-cast ceramic dual-port vessel drum family (UDU-S/M/L/XL). The chamber volume plus mouth and side ports form a coupled dual-Helmholtz resonator; the player strikes the side port for the bass "water" tone and the body for slaps. Fired geometry, not green geometry, is acoustic authority — the master carries `master_scale_factor = 1.136` for cone-6 stoneware 12% shrinkage.
- Environment: hand percussion, indoor; ceramic body is brittle (drop risk); fired-clay dimensional variance dominates tolerance.
- Target qty: 1 per family member (prototypes). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal (UDU-M) | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Chamber volume | 439.8 cu in | fired-volume measurement gate | sets both port pitches | family-spec.csv (measurement_required) |
| Mouth diameter | 3.0 in | port-edge measurement gate | mouth Helmholtz pitch | family-spec.csv |
| Side port diameter | 2.0 in | port-edge measurement gate | side/bass pitch | family-spec.csv |
| Wall thickness | 0.30 in | slip-cast control | structure + tone | family-spec.csv |
| Master scale factor | 1.136 | verify with fired shrinkage coupons | green→fired dimensional authority | cad/udu_master.scad |

## Incidental (free for DFM)

- Surface texture/burnish, decorative banding, exact foot profile.

## Must-nots (DFM may never violate)

- Do not treat green (unfired) dimensions as acoustic authority — all pitch predictions apply to FIRED geometry.
- Port edges must stay smooth/radiused per slip-cast plan; sharp fettled edges shift port behavior.
- No member may be promoted past measurement_required until fired-volume and port measurements land (family-spec dimension_provenance).

## Material intent

- Preferred: Cone 6 stoneware, 12% shrinkage (family-spec.csv). Substitutions require new shrinkage factor + re-prediction.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT run — no concessions logged.
