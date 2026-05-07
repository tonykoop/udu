# Importing the Udu Design Table into SolidWorks

The design table at `cad/sw-design-table.xlsx` is generated from
`family-spec.csv` by `scripts/generate_sw_design_table.py` (in the
instrument-maker-v4 skill). Re-run the generator any time
`family-spec.csv` changes.

## One-time wiring (per part)

1. Open `UDU-000_MasterLayout.SLDPRT` in SolidWorks.
2. Verify the global equations from
   [`MasterLayout-equations.txt`](MasterLayout-equations.txt) are
   present in `Tools > Equations > Manage Equations > Global Variables`.
   Any missing global must be added by hand before the design table
   imports cleanly.
3. `Insert > Tables > Design Table > From Existing File`.
4. Browse to `../cad/sw-design-table.xlsx` and select.
5. SolidWorks reads the file and shows the configurations to import:
   - `MASTER_TEMPLATE`
   - `UDU-S`
   - `UDU-M`
   - `UDU-L`
   - `UDU-XL`
6. Click `OK` in the configurations dialog.
7. Right-click each configuration in `ConfigurationManager` and
   `Show Configuration` to verify the rebuild succeeds.

## Verification after import

After import, open `Tools > Evaluate > Mass Properties` for each
configuration in turn. The `chamber_volume_cuin` global should match
the volume you'd compute by hand from `body_diam_in`, `body_height_in`,
and `shape_factor`. Differences >1% mean the SW geometry has drifted
from the formula — investigate before accepting the import.

## Updating after a `family-spec.csv` edit

```bash
# Regenerate the SW design table xlsx
python3 /path/to/skill/scripts/generate_sw_design_table.py \
  C:\Users\Tony\Documents\GitHub\udu \
  --output cad/sw-design-table.xlsx \
  --part-name UDU-000_MasterLayout
```

Then in SolidWorks:

1. Right-click the existing design table in `ConfigurationManager`.
2. `Edit Table > Configurations` — SW asks if you want to keep current
   values or re-read from the file. Choose **re-read from file**.
3. Verify that no configuration broke during the re-read; activate each
   in turn to test rebuild.
4. If a configuration fails to rebuild, the most common cause is a new
   global referenced in the design table that wasn't added to
   `Tools > Equations` first — go back to step 2 of the one-time wiring.

## Drift detection

After making non-trivial changes in SW (sketch reorganization,
feature splits), capture the SW state before and after with the macro
and diff:

```bash
# Before edit
# (run Extract_Dimensions.swp in SW; save CSV as cad/dimensions/before-<date>.csv)

# After edit
# (run Extract_Dimensions.swp in SW; save CSV as cad/dimensions/after-<date>.csv)

python3 /path/to/skill/scripts/ingest_dimension_csv.py \
  --csv cad/dimensions/after-<date>.csv \
  --workbook udu-design-table.xlsx \
  --design-sheet Master_Inputs \
  --tolerance-percent 0.5 \
  --report sw-reference/drift-<date>.md
```

Any unintended dimension change shows up in the drift report and gets
escalated.
