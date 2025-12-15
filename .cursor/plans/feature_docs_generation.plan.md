## Goal

Generate **one markdown file per top-level feature area** from `prompts/app_specs.md` (scope = **1a**) and enrich each doc with relevant UI details from `prompts/app_ux_specs.md`. Use filename convention **2b**: `<NN>_<feature_name>.md`. Store all generated files in `prompts/`.

## Inputs to follow

- Source specs: `prompts/app_specs.md`
- UX specs: `prompts/app_ux_specs.md`
- Output location: `prompts/`
- Naming: `<NN>_<feature_name>.md` (zero-padded, e.g. `01_user_account_onboarding.md`)

## Output files to create (proposed mapping)

1. `01_user_account_onboarding.md`
2. `02_card_scanning_identification.md`
3. `03_collection_management.md`
4. `04_deck_builder.md`
5. `05_deck_completion_analysis.md`
6. `06_card_relationships_synergies.md`
7. `07_meta_trends_integration.md`
8. `08_monetization_scan_credits_iap.md`
9. `09_pokemon_card_database_mirror.md`
10. `10_pricing_integration.md`
11. `11_storage_sync_offline.md`
12. `12_ui_ux_accessibility_navigation.md`
13. `13_privacy_security_compliance.md`
14. `14_non_functional_requirements.md`
15. `15_post_mvp_enhancements.md`

Notes:

- Items 9–11 come from `Integrations & Backend` + `Storage/Sync` + offline notes; they remain “feature areas” per scope 1a.
- `prompts/` may be git-ignored; that’s OK since user requested the outputs live there.

## Standard template for each feature doc

Each file will use the same sections so an AI builder can implement consistently:

- **Purpose & user value**
- **Primary user stories / jobs-to-be-done**
- **Entry points & navigation**
- Routes and which screens surface the feature (from `app_ux_specs.md`)
- AppBar actions, bottom nav expectations, dialogs/bottom sheets
- **UI requirements (Material 3 widgets)**
- Screen-by-screen elements involved in this feature (only the relevant subset)
- Component specs: buttons, fields, chips, lists, cards, empty/loading/error states
- **Core workflows**
- Step-by-step flows including success/failure branches
- **Data model & storage**
- Firestore collections/docs, local cache schema (high-level), identifiers
- **Integrations**
- External APIs, request/response expectations, caching strategy
- **Rules & validation**
- Format legality, scan thresholds, limits, etc.
- **Edge cases**
- Offline, partial sync, retries, duplicates, pagination, permissions
- **Analytics events**
- Minimal event list aligned to business goals (scan funnel, conversion)
- **Acceptance criteria**
- Bullet list of “done” requirements for this feature

## Execution steps

1. Parse `prompts/app_specs.md` into the 15 feature areas above.
2. For each feature area, extract the matching screens/components from `prompts/app_ux_specs.md`.
3. Write each `<NN>_<feature_name>.md` in `prompts/` using the standard template, with concrete widget-level guidance (Material 3), state handling, and implementation-ready behavior.
4. Quick consistency pass:

- Navigation terminology matches across docs
- Scan credits and monetization references are consistent
- Avoid contradictions between UX specs and feature docs

## Outputs are documentation-only

These files are intended as AI-friendly implementation prompts/specs. They may be git-ignored (`prompts/`), which is acceptable.