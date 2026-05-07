# Udu Drum Family — Risk Register

> Red-team pass on the slip-cast ceramic udu family (UDU-S/M/L/XL). Every risk
> below has a verifiable test attached. High-severity risks are flagged for
> Tony's decision before we commit material.

This document is the v4 obligation produced by the `red-team` specialist; the
verifier asks "is this packet internally consistent?" while red-team asks
"is this design actually safe to build?" The two are independent — a polished
self-consistent packet can still fail at the bench.

Categories enumerated below: **Acoustic**, **Structural**, **Ergonomic**,
**Supply**, **Fit/Finish**.

---

## Acoustic

### [Acoustic] Predicted frequencies diverge from workbook targets at family extremes — HIGH

**Symptom:** UDU-S mouth tone reads ~340 Hz vs D♯4 target 311 Hz (+157 ¢
sharp); UDU-XL mouth tone reads ~154 Hz vs F3 target 175 Hz (-220 ¢ flat).
Family targets at the extremes are out of reach of bisque-stage trim alone
(the trim band is roughly ±100 ¢ before the port becomes structurally
compromised or visually disproportionate).

**Mechanism:** The workbook used identical port diameters (mouth 3 in, side
2 in) and a fixed shape factor 0.70 across the family. Helmholtz frequency
scales as √(A / (V · L)), so holding A constant while V scales linearly
makes the predicted pitch scale as V^(-1/2). The targets were chosen on a
musical interval ladder (mouth tones D♯4 / B3 / G♯3 / F3 — descending major
3rd / minor 3rd / minor 3rd) but the *acoustic* scaling of the chosen
geometry doesn't match the *musical* scaling of the targets.

**Test:** Cast a one-off small body (UDU-P1) and measure the mouth tone
with a tuner before the family molds are committed. Cents error >100
on the smallest member confirms the family-level mismatch.

**Mitigation:**
- Drop the UDU-S mouth diameter to ≈2.5 in (shrinks predicted Hz back
  toward 310 Hz) and grow the UDU-XL mouth toward ≈3.5–4.0 in (grows
  predicted Hz back toward 175 Hz).
- *Or* keep ports constant and shift the family targets onto an
  acoustically-honest ladder (e.g., mouth tones at fixed volume ratios).
- Document whichever path is chosen in `family-spec.csv` and re-emit the
  per-member SVG drawings.

**Severity:** **High** — design change required, not just a manufacturing
adjustment. Escalated to Tony for decision before Tier-3 production CAD.

---

### [Acoustic] Coupled-mode pitch when both ports are partly open is not predicted — Medium

**Symptom:** A real udu's musical character is the *sweep* between the
mouth and side tones as the player covers/uncovers each port. Single-port
formulas (used in the design table and Wolfram starter) do not predict
the coupled-mode pitch or the transition curve.

**Mechanism:** Two ports sharing a chamber form a 2-DOF Helmholtz system
with eigenmodes at frequencies that are not the simple geometric mean of
the single-port frequencies. The coupling strength depends on port-area
ratio and player hand impedance.

**Test:** Build UDU-P2 (Medium), record audio at five hand conditions
(mouth fully open / 25% / 50% / 75% / fully closed against a rigid hand
seal, side hole open in each), spectrogram analysis of fundamental
frequency vs hand condition. Compare to the placeholder coupled-mode
eigenvalue model in `wolfram-starter.wl`.

**Mitigation:** Empirically calibrate the coupling term in
`wolfram-starter.wl` from the UDU-P2 measurements; record the calibrated
coupling coefficient in the per-family corrections database via
`scripts/record_measurement.py`.

**Severity:** Medium — affects predictive fidelity, not the build.
Required before declaring the physics model "validated."

---

### [Acoustic] Glaze fire shifts measured pitch — Medium

**Symptom:** A bisque-tuned udu plays sharp/flat after glaze fire. Pitch
shift typically 5–25 ¢ depending on glaze thickness and exterior coverage.

**Mechanism:** Glaze adds wall mass (lowers shell-resonance damping
slightly) and can subtly change the interior surface impedance at high
frequencies. The Helmholtz fundamental itself is dominated by chamber
volume × port area, but glaze film thickness can effectively reduce
chamber volume by 1–3% on a 1/2" wall vessel.

**Test:** Record mouth + side tones for UDU-P2 at three stages:
greenware, bisque, glaze-fire. Log all three rows in `validation.csv`
with environment (temp / RH).

**Mitigation:** Cut ports slightly under-target at leather-hard;
final-tune at bisque if needed; commit to glaze fire only when bisque
tones are within ±25 ¢ of target. Glaze interior is forbidden (already
called out in build).

**Severity:** Medium — process-controllable, not a design defect.

---

## Structural

### [Structural] Wall thickness margin at side-hole edge — Medium

**Symptom:** The side hole is cut at leather-hard and then enlarged at
bisque for tuning. Each enlargement step removes wall material around
the port. Repeated tuning cycles can leave the rim too thin (<1/8")
for hand-slap durability.

**Mechanism:** Hand slap on the port edge produces local stress
~10–20× the static body load. A 1/8" minimum wall is the rule for
Cone-6 stoneware in domestic-use vessels; below that the slap-edge
chips on first impact.

**Test:** Slap-test a UDU-P0 port-tile with measured edge thicknesses
(0.30, 0.20, 0.15, 0.10 in). Document the thickness at which the rim
chips after 100 slaps with a moderate hand.

**Mitigation:** Limit total tuning enlargement to ≤30% of original port
area. Build a tuning trim *budget* into `validation.csv`: if predicted
cents-error >100 ¢, flag the body for rebuild rather than over-trim.
Round all port edges with a damp finger / soft rib before bisque.

**Severity:** Medium — manufacturing-controllable. Becomes High on
UDU-XL where extreme cents-error correction is implied (see Acoustic
risk #1).

---

### [Structural] Greenware crack risk on long unsupported wall — Medium

**Symptom:** UDU-XL's 14" diameter × 16" tall body has a 6"+ unsupported
wall span between mouth and base after demold. Greenware shrinkage during
drying produces hoop stress; cracks initiate at the side-hole notch and
propagate vertically.

**Mechanism:** Differential drying — interior surface dries more slowly
than exterior — produces a stress gradient. Side-hole cut creates a
stress concentrator. Stoneware tensile strength at 18–22% moisture
content is ~50 PSI; predicted hoop stress at the crack location is
~30–40 PSI for the XL geometry.

**Test:** First UDU-XL casting carries a strain gauge or dot-grid on
the exterior wall; photograph at 24-hour intervals during drying;
inspect side-hole crater for crack initiation. Repeat the same protocol
on UDU-L as a sanity check.

**Mitigation:** Slow-dry under plastic sheet for 5–7 days; cut side hole
*after* initial drying, not at leather-hard. If cracks appear in the
first XL, increase wall thickness to 0.40 in for that size only and
re-emit XL drawings.

**Severity:** Medium for UDU-S/M/L (geometry is well-supported), High
for UDU-XL specifically — escalated.

---

## Ergonomic

### [Ergonomic] Side-hole height for seated player — Low

**Symptom:** Player seated on a low stool reaches across an UDU-XL
14" diameter body to slap the side hole; reach distance ~12" puts
the slap stroke off the player's natural arc.

**Mechanism:** Standing or kneeling play accommodates the larger
bodies; seated play (most common for solo recording) constrains the
side-hole height to the 9th–10th-percentile player's natural arm-arc.
For UDU-S/M the side hole at 5–6" height clears this; UDU-L/XL push
the side hole to 7–8" which is the upper edge of the comfort band.

**Test:** Mock up the UDU-XL profile in foam core; place on a 14" stand
and have three players (5th-, 50th-, 95th-percentile arm reach) play
the side hole for 60 seconds; rate comfort 1–5.

**Mitigation:** Document recommended playing position per size in
`assembly-manual.md`. UDU-XL is concert-bass with a stand; specify the
stand height so the side hole sits at the seated player's elbow.

**Severity:** Low — not a build defect; a documentation obligation.

---

### [Ergonomic] Mouth rim sharpness on hand seal — Medium

**Symptom:** Player seals the mouth with a flat hand strike. A sharp
or undercut rim cuts the palm during repeated play; even a slightly
acute angle causes redness on the heel of the palm after 10 minutes
of continuous play.

**Mechanism:** Hand seal needs full-area contact with no high points.
The fired rim profile depends on the master geometry, demold cleanup,
and any leather-hard finger-rolling. A clean radius ≥1/8" on the rim
is the comfort minimum.

**Test:** UDU-P0 cup tile carries three rim radius variants
(1/16", 1/8", 1/4"). 5-minute continuous play at each; player rates
comfort + check for skin redness.

**Mitigation:** Specify rim radius ≥1/8" in the master CAD. Roll the
rim with a damp finger / soft rib at leather-hard before bisque.
Reject any body where the rim radius reads <1/16" after demold.

**Severity:** Medium — affects long play sessions. Easy to fix at the
master geometry, hard to fix after firing.

---

## Supply

### [Supply] Cone-6 casting slip shrinkage variance — Medium

**Symptom:** Two batches of "Cone 6 stoneware casting slip" from the
same supplier shrink 11.5% and 13.0% respectively. Master scale factor
1/(1 - shrinkage) shifts by ~1.5% (from 1.130 to 1.149), enough to
push a tuned body 30–40 ¢ off target.

**Mechanism:** Shrinkage is a function of clay particle size, water
content, organic content, and firing schedule. Manufacturers specify
a *nominal* shrinkage; actual shrinkage is batch-dependent and the
spec is rarely tighter than ±1.5%.

**Test:** Pour three shrinkage coupons (4" × 1" × 0.25" bars) per
new slip batch; bisque-fire all three; measure shrinkage; record in
`validation.csv` shrinkage column.

**Mitigation:** **Re-derive** the master scale factor from the
*measured* batch shrinkage before printing each new master, not from
the workbook's 12% assumption. The OpenSCAD master takes shrinkage as
a parameter; this is already wired in, but the procedure must be
called out in the assembly manual.

**Severity:** Medium — process-controllable. Skipping the coupon
test is the failure mode, not the slip itself.

---

### [Supply] Bambu X1C build envelope vs UDU-L/XL master — High

**Symptom:** Bambu X1C build volume is ~256 × 256 × 256 mm (~10" cube).
UDU-L master half is 12" tall × 12" wide × 6" deep at 12% shrinkage
scaling — exceeds the print bed in two dimensions. UDU-XL is worse.

**Mechanism:** Master halves print as one-shot solids for surface
finish; splitting them adds layer-line discontinuities that telegraph
into the plaster mold and ultimately the cast surface.

**Test:** Open the UDU-L master.scad output in OpenSCAD, export STL
sliced as a half, load in BambuStudio — confirm "out of build volume"
warning before printing.

**Mitigation:** Three options:
1. **Multi-section masters** — split each L/XL master into 2–3
   stackable sections, glue and surface-fill at the joint, sand smooth
   before plaster pour.
2. **Outsource print** — Shapeways, Craftcloud, or local Maker Nexus
   bay with a larger printer (Prusa XL, Voron 350+ build, 600 mm
   format).
3. **Defer L/XL until the print farm grows** — UDU-S and UDU-M fit
   the X1C; ship those first. (Already explicitly called out in the
   README "Status" table.)

**Severity:** **High** for UDU-L/XL — design constraint that must be
resolved before Tier-3 CAD. Escalated to Tony.

---

## Fit / Finish

### [Fit/Finish] Glaze adhesion at port edge — Low

**Symptom:** Wax resist at the mouth and side-hole rim is meant to
keep the rim glaze-free for hand contact. A thin or uneven wax
application lets glaze creep onto the rim during dipping; the rim
glaze then chips off in service or feels gritty under the hand.

**Mechanism:** Wax resist relies on the contact angle between liquid
glaze and a hydrophobic film. Low-temperature wax (<140 °F drip
point) re-wets if the bisque body is warm from a kiln just opened.
Brush strokes leave thin spots.

**Test:** Wax-resist a bisque coupon along a pencil-marked line;
dip-glaze; bisque-fire; inspect line edge under raking light for
glaze creep.

**Mitigation:** Wax under cool conditions (≤80 °F). Two thin coats
beat one thick coat. Inspect each rim before glaze fire; touch up wax
gaps. Specify the wax type in `bom.csv` (currently "wax resist" — too
generic).

**Severity:** Low — easy to catch at QC, affects play comfort if missed.

---

### [Fit/Finish] Master split-line transfer to cast body — Medium

**Symptom:** The two-piece plaster mold has a parting seam where the
mold halves meet. Casting transfers a fine ridge along this seam onto
the greenware body. If the seam runs through the hand-contact zone,
the player feels a subtle bump on each strike.

**Mechanism:** The mold split is geometrically necessary for demold;
no slip-cast body avoids it. The skill is to *route* the split line
away from hand-contact surfaces.

**Test:** Trace the proposed split line on the master CAD; overlay
the hand-contact heat-map (mouth seal palm + side-hole slap fingers).
Any overlap is a design issue; relocate the split line.

**Mitigation:** Position split line on the front-back equator of the
body, not on the side-hole face. Trim split-line ridge with a damp
fettling tool at leather-hard; final smooth before bisque.

**Severity:** Medium — design + process. Already addressed in the
mold strategy of `design.md`; this risk register documents the *why*.

---

## Cross-cutting / lineage

### [Cultural] Public-facing copy must respect Igbo lineage — High (procedural)

**Symptom:** Listing the udu in a recruiter-facing portfolio without
the lineage attribution reads as appropriative or naïve. The udu is
not a generic ceramic bass pot.

**Mechanism:** Documentation is a public artifact even when the build
is private. Recruiters, students, and other makers will read the
README and the build-log site without context.

**Test:** Pre-publication review by a knowledgeable second reader
(family member, cultural-sensitivity reader, or peer maker familiar
with West African instrument lineage). Sign-off recorded in `notes/`
before the build-log site goes live.

**Mitigation:** The README, `design.md`, and the build-log site each
carry an explicit attribution paragraph. The license clause (CC-BY 4.0)
is for the *engineering documentation*, not for the instrument concept
itself. Already captured in the LICENSE file and design.md "Cultural
And Product Note" — this risk register documents the *requirement*,
not a defect.

**Severity:** High (procedural — block publication of build-log site
until pre-pub review is signed).

---

## Risk summary

| ID | Category | Severity | Status |
|---|---|---|---|
| ACO-01 | Acoustic — family-extremes target mismatch | High | Escalated |
| ACO-02 | Acoustic — coupled-mode unmodeled | Medium | Empirical loop |
| ACO-03 | Acoustic — glaze-fire pitch shift | Medium | Process |
| STR-01 | Structural — port-edge wall margin | Medium | Process |
| STR-02 | Structural — XL greenware crack | Medium / High XL | Escalated for XL |
| ERG-01 | Ergonomic — side-hole reach | Low | Documentation |
| ERG-02 | Ergonomic — mouth rim sharpness | Medium | Master-CAD |
| SUP-01 | Supply — slip shrinkage variance | Medium | Process |
| SUP-02 | Supply — Bambu envelope vs L/XL | High | Escalated |
| FIT-01 | Fit/Finish — glaze creep at port edge | Low | QC |
| FIT-02 | Fit/Finish — split-line transfer | Medium | Master-CAD |
| CUL-01 | Cultural — lineage attribution | High procedural | Pre-pub review |

**High-severity, escalated to human:** ACO-01 (family-extremes target
mismatch), STR-02 (XL crack risk), SUP-02 (Bambu envelope), CUL-01
(pre-pub review).

These four block declaring the v4.1 udu packet "production-tagged" until
Tony resolves them.
