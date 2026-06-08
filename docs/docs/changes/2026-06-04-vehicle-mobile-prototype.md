# T1-T20 Change Document: Vehicle Self-Tracking Mobile Prototype

## T1 Change Title

| Field | Value |
|---|---|
| Change ID | VST-MOBILE-PROTOTYPE-20260604 |
| Module | Flutter Mobile App / Docs |
| Date | 2026-06-04 |
| Owner / Agent | Codex |
| Status | Done |

## T2 Requirement

- User request: read all Markdown docs under `docs`, then create a VEHICLE SELF-TRACKING MOBILE APP SYSTEM using the provided scope.
- Business goal: provide a mobile prototype for students to track their own motorcycle around E1 parking at Mae Fah Luang University.
- Success outcome: Flutter app replaces the starter counter screen with login, tracking map, vehicle profile, route history, and detection settings.

## T3 Source Evidence

| Area | Source path / route / command | What was verified |
|---|---|---|
| Workflow | `docs/docs/AI-WORKFLOW.md` | source evidence, T1-T20, test gate, PRD update rules |
| Agent docs | `docs/docs/agents/*.md` | orchestrator, PO, data, frontend, security, QA, release expectations |
| PRD baseline | `docs/docs/prd/PRD-NewSystem.md` | existing PRD is for NewSystem and does not describe this mobile product |
| Template | `docs/docs/templates/T1-T20-change-document.md` | required handoff shape |
| Flutter app | `lib/main.dart` | starter counter app was the current behavior |
| Dependencies | `pubspec.yaml` | only Flutter SDK and Cupertino icons were available |
| Test | `test/widget_test.dart` | starter counter test needed replacement |
| MCP resources | `list_mcp_resources` | no MCP design resources were available in this session |

## T4 Current Behavior

- Current API behavior: no backend API is implemented in this Flutter workspace.
- Current UI behavior: starter Flutter counter app.
- Current data behavior: no vehicle data model.
- Current permission behavior: no real authentication; prototype sign-in entry only.

## T5 Impacted Agents

| Agent | Required? | Reason |
|---|---|---|
| Orchestrator | yes | source discovery and delivery sequencing |
| Product Owner | yes | FR/AC and product scope |
| Data Model | yes | vehicle/profile/route data shape for prototype |
| Backend | no | no Python backend implemented in this change |
| Frontend | yes | Flutter UI implementation |
| Security IAM | yes | authentication and licence plate/privacy risks documented |
| QA/UAT | yes | widget test and analyzer verification |
| Release/Ops | yes | prototype run/rollback notes |

## T6 Scope

In scope:

- Flutter mobile UI prototype.
- Local demo data for vehicle profile, route logs, CCTV rules, and map points.
- Custom map-style view showing route path, CCTV markers, E1 zone, and guard radius.
- Widget test update.
- README and PRD/change docs.

Out of scope:

- Real MFU OAuth integration.
- Real Google Maps SDK.
- Python backend, MongoDB, YOLOv11, ByteTrack, push notification, and image upload integrations.

## T7 Functional Requirements

| FR ID | Requirement | Actor | Priority |
|---|---|---|---|
| FR-VST-001 | Sign in through Lamduan Mail entry screen | Student | Must |
| FR-VST-002 | View vehicle location in E1 map view | Student | Must |
| FR-VST-003 | Edit vehicle model and licence plate | Student | Must |
| FR-VST-004 | Add/edit motorcycle photos for Front, Back, Left, Right | Student | Must |
| FR-VST-005 | View route history as a drawn path from Point A to B | Student | Must |
| FR-VST-006 | Customize detection start delay, default 1-2 minutes | Student | Must |

## T8 Acceptance Criteria

| AC ID | FR ID | Given | When | Then |
|---|---|---|---|---|
| AC-VST-001 | FR-VST-001 | app opens | user taps Lamduan Mail button | dashboard is shown |
| AC-VST-002 | FR-VST-002 | dashboard is shown | local vehicle data is available | E1 map, CCTV, status, and confidence are visible |
| AC-VST-003 | FR-VST-003 | Vehicle tab is open | user edits fields and saves | app confirms saved values |
| AC-VST-004 | FR-VST-004 | Vehicle tab is open | user taps angle action | photo angle state changes |
| AC-VST-005 | FR-VST-005 | History tab is open | user selects a route log | map path updates |
| AC-VST-006 | FR-VST-006 | Settings tab is open | user adjusts range slider | delay label updates |

## T9 API Contract

No runtime API contract was implemented.

Planned future endpoints:

| Method | Endpoint | Permission | Request | Response | Error behavior |
|---|---|---|---|---|---|
| GET | `/api/v1/vehicles/me` | authenticated student | none | vehicle profile | 401 if unauthenticated |
| PUT | `/api/v1/vehicles/me` | authenticated student | model, licence plate, photos | updated profile | validation errors |
| GET | `/api/v1/vehicles/me/location` | authenticated student | none | last known location and camera | 404 if no detection |
| GET | `/api/v1/vehicles/me/routes` | authenticated student | date range | route history | validation errors |
| PUT | `/api/v1/vehicles/me/detection-settings` | authenticated student | start delay range | settings | validation errors |

## T10 Data Model / Migration

| Item | Decision | Evidence |
|---|---|---|
| Schema change | no | no backend/database in current workspace |
| Migration | no | local demo data only |
| Seed/backfill | no | `lib/data/demo_tracking_data.dart` provides sample data |
| Index | no | no database implemented |
| Rollback | revert Flutter and docs files | no persistent data impact |

## T11 Backend Plan / Changes

- Routes: none.
- Guards: future backend must enforce authenticated MFU student ownership.
- Services: none.
- Controllers/models: none.
- Tests: not applicable for backend in this workspace.

## T12 Frontend Plan / Changes

- Route: single Flutter app shell with bottom navigation.
- API wrapper: not added; no confirmed backend contract yet.
- State: local Flutter state for sign-in, tab selection, route selection, detection range, and photo angle state.
- Page: `lib/vehicle_tracking_app.dart`.
- Components: `lib/widgets/tracking_map.dart`, local reusable widgets.
- Tests: `test/widget_test.dart`.

## T13 Security / Permission

| Concern | Decision / Evidence |
|---|---|
| Authentication | Prototype has Lamduan Mail entry only; real MFU OAuth remains future work |
| Authorization path/action | Future backend must scope every vehicle API to the signed-in student |
| Data scope | `self` only; students must access only their own vehicle |
| Audit | Future movement alerts and profile edits should be auditable |
| Input validation | Future backend must validate licence plate, model, photo metadata, and delay range |
| Error/secret leakage | No secrets added; no API keys committed |

## T14 Test Plan

| Test ID | Type | Role/User | Steps | Expected |
|---|---|---|---|---|
| TC-VST-001 | widget | student | open app, tap Lamduan Mail | dashboard appears |
| TC-VST-002 | widget | student | open Vehicle tab | profile and photo angle UI appears |
| TC-VST-003 | widget | student | open History tab | route history appears |
| TC-VST-004 | widget | student | open Settings tab | detection range slider appears |
| TC-VST-005 | static | developer | run analyzer | no issues |

## T15 Implementation Summary

| File | Change |
|---|---|
| `lib/main.dart` | replaced starter counter entry with `VehicleTrackingApp` |
| `lib/vehicle_tracking_app.dart` | added login, dashboard, vehicle profile, route history, and settings UI |
| `lib/models/tracking_models.dart` | added vehicle, map point, route log, and detection rule models |
| `lib/data/demo_tracking_data.dart` | added local prototype data |
| `lib/widgets/tracking_map.dart` | added custom map-style route/CCTV painter |
| `test/widget_test.dart` | replaced counter test with vehicle tracker flow test |
| `README.md` | replaced starter README with project notes |
| `docs/docs/prd/PRD-VehicleSelfTracking.md` | added product PRD baseline |
| `docs/docs/changes/2026-06-04-vehicle-mobile-prototype.md` | added this T1-T20 handoff |

## T16 Tests Run / Evidence

| Command | Result | Evidence / Notes |
|---|---|---|
| `dart format lib test` | pass | Dart files formatted |
| `flutter analyze` | pass | no issues found |
| `flutter test` | pass | all widget tests passed |
| `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080` | pass | app served at `http://127.0.0.1:8080` |
| `Invoke-WebRequest -Uri http://127.0.0.1:8080 -UseBasicParsing` | pass | returned `200 OK` |

Commands not run:

| Command | Reason | Risk |
|---|---|---|
| backend tests | no backend exists in this Flutter workspace | future backend integration is unverified |
| Google Maps device smoke | Google Maps SDK/API key not configured | real map rendering remains future work |

## T17 PRD / Docs Updated

| Document | Updated? | Reason |
|---|---|---|
| `docs/docs/prd/PRD-VehicleSelfTracking.md` | yes | new product requirement baseline |
| `README.md` | yes | project description and run/test commands |
| `docs/docs/changes/2026-06-04-vehicle-mobile-prototype.md` | yes | T1-T20 change evidence |

## T18 Risks / Blockers / Assumptions / Decisions

| ID | Type | Description | Owner | Status |
|---|---|---|---|---|
| A-001 | Assumption | MCP design id was not accessible because no MCP resources were available | Frontend | open |
| A-002 | Assumption | Prototype uses local demo data until backend contract exists | Frontend | closed |
| D-001 | Decision | Avoid adding Google Maps dependency until API key/platform setup is available | Mobile | closed |
| R-001 | Risk | Real CCTV/AI accuracy and privacy controls are not validated by this prototype | AI/Security | open |
| R-002 | Risk | OAuth and ownership checks must be implemented before production use | Backend/Security | open |

## T19 Release / Rollback

- Release steps: run `flutter pub get`, `flutter analyze`, `flutter test`, then build target platform.
- Smoke checks: sign in, Track tab, Vehicle tab, History tab, Settings tab; local web preview is available at `http://127.0.0.1:8080`.
- Monitoring: not applicable for local prototype.
- Rollback trigger: prototype UI rejected or blocks app build.
- Rollback steps: revert files listed in T15.

## T20 Final Handoff

```txt
Feature: Vehicle Self-Tracking Mobile Prototype
Status: Done
Changed files: lib/main.dart, lib/vehicle_tracking_app.dart, lib/models/tracking_models.dart, lib/data/demo_tracking_data.dart, lib/widgets/tracking_map.dart, test/widget_test.dart, README.md, docs/docs/prd/PRD-VehicleSelfTracking.md, docs/docs/changes/2026-06-04-vehicle-mobile-prototype.md
Routes: no backend routes
UI routes: Flutter tabs Track, Vehicle, History, Settings
Permission: future self-scoped MFU OAuth required
Data migration: no
Tests run: dart format lib test; flutter analyze; flutter test; local web server 200 OK
PRD/docs: updated
Security decision: pass-with-risk for prototype; OAuth/ownership/privacy pending
QA decision: prototype widget test passed
Release decision: local prototype ready
Open risks: real OAuth, Google Maps, backend, MongoDB, YOLOv11, ByteTrack, push alerts, image upload
Next owner: Mobile/backend team for integration contracts
```
