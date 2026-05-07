# Extract_Dimensions.swp — Run Checklist

Before running the macro on `UDU-000_MasterLayout.SLDPRT`:

- [ ] Save the part. The macro reads in-memory state but file-save
      gives you a rollback point if the macro errors out.
- [ ] Activate the configuration you want to capture as the
      *primary* row. The macro walks all configurations regardless
      of which is active, but the active config drives the
      `AssemblyConfigName` field.
- [ ] Confirm `Tools > Options > External References > Search routing`
      points at the correct design-table xlsx — drift at this layer
      causes silent value mismatches.
- [ ] Note the date and active configuration in the macro output
      filename: `cad/dimensions/<date>-<config>.csv`.

## Running the macro

1. `Tools > Macro > Run > Extract_Dimensions.swp`
2. The macro shows a file-save dialog; save the CSV into
   `cad/dimensions/<date>-<active-config>.csv`.
3. Wait for the macro to finish. Expect ~5–15 seconds for a single-part
   model with 4 configurations.

## Verifying the output

- [ ] Open the CSV in Excel (or `csvlook < cad/dimensions/<file>.csv`
      from a shell). Row count should be approximately
      `(globals × configurations) + (feature dims × configurations)`.
      For the udu master with 14 globals and ~10 feature dimensions
      across 4 active configurations, expect ~96 rows.
- [ ] Spot-check that the `Value_in` column shows real inch values,
      not millimeter-converted approximations. (E.g., `body_diam_in`
      should read `10.0`, not `9.999...`.)
- [ ] Confirm the `IsGlobalVar` column has TRUE for the 14 globals
      and FALSE for the 10 feature dimensions.

## Diffing against the Excel design table

Once the CSV is captured:

```bash
python3 /path/to/skill/scripts/ingest_dimension_csv.py \
  --csv cad/dimensions/<date>-<config>.csv \
  --workbook udu-design-table.xlsx \
  --design-sheet Master_Inputs \
  --tolerance-percent 0.5 \
  --report sw-reference/drift-<date>.md
```

The report flags:
- **Match** — value equal within tolerance.
- **SW-only** — dimension in the SW model that doesn't appear in the
  Excel design table.
- **Excel-only** — dimension in Excel that the SW model doesn't have.
- **Mismatch** — both sides have it but values disagree.

A clean run reports zero issues. Anything else escalates to Tony for
manual reconciliation.
