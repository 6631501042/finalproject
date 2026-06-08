# PRD: Vehicle Self-Tracking Mobile App System

## Document Control

| Field | Value |
|---|---|
| Product | Vehicle Self-Tracking Mobile App System |
| Version | 0.1 |
| Status | Prototype Baseline |
| Source checked date | 2026-06-04 |
| Primary app source | `lib/main.dart`, `lib/vehicle_tracking_app.dart` |
| Related workflow | `docs/docs/AI-WORKFLOW.md` |

## Product Overview

The system helps Mae Fah Luang University students track the last known location of their own motorcycle on campus. The mobile app focuses on E1 parking CCTV detection, vehicle profile management, route history, and detection timing preferences.

## Objectives

1. Track the location of the user's own vehicle.
2. Provide accessible and user-friendly vehicle self-tracking through a mobile platform.
3. Enhance user confidence and peace of mind regarding vehicle location on campus.

## Users And Authentication

| Item | Requirement |
|---|---|
| User group | Mae Fah Luang University students |
| User identity | Name and Lamduan Mail account |
| Authentication | Lamduan Mail through MFU OAuth |
| Prototype status | Current Flutter prototype includes a sign-in entry screen only; OAuth is not connected yet |

## Functional Requirements

| FR ID | Requirement | Priority |
|---|---|---|
| FR-VST-001 | Student can sign in through Lamduan Mail / MFU OAuth | Must |
| FR-VST-002 | Student can view the vehicle's last known location in a map view | Must |
| FR-VST-003 | Student can add or edit motorcycle photos for Front, Back, Left, and Right | Must |
| FR-VST-004 | Student can add or edit vehicle model and licence plate | Must |
| FR-VST-005 | Student can view historical travel route as a path from Point A to Point B | Must |
| FR-VST-006 | Student can customize CCTV detection start time; default is 1-2 minutes | Must |
| FR-VST-007 | System shows last detected camera when no other CCTV can detect the vehicle | Must |

## Scenario And Detection Rules

| Area | Rule |
|---|---|
| Coverage | CCTV detection is scoped to E1 parking lot at Mae Fah Luang University |
| Operating condition | Daytime only; not reliable at night, in rain, or in fog |
| Stationary trigger | Detection starts after the vehicle is motionless for the configured delay, default 1-2 minutes |
| Save interval | Confirmed detection data is saved every 10 minutes |
| Movement alert | If the stationary vehicle leaves the defined radius, the system alerts the mobile app |
| Out of range | If the vehicle disappears from camera range, the app shows the last camera that detected it |

## Technology Scope

| Layer | Planned technology | Prototype status |
|---|---|---|
| Mobile app | Flutter | Implemented as local UI prototype |
| Map | Google Maps | Represented by a custom map-style Flutter view until API key/backend are configured |
| Backend | Python | Not implemented in this Flutter prototype |
| Database | MongoDB | Not implemented in this Flutter prototype |
| AI detection | YOLOv11 for vehicle body and licence plate recognition | Not implemented |
| Tracking | ByteTrack for position and direction | Not implemented |
| Compute | Cloud systems | Not implemented |

## Mobile UI Baseline

| Screen | Behavior |
|---|---|
| Login | Shows MFU Vehicle Tracker and Lamduan Mail entry action |
| Track | Shows current E1 parking status, map-style location, CCTV marker, guard radius, and detection rules |
| Vehicle | Edits vehicle model, licence plate, and four photo angle placeholders |
| History | Shows route history logs and a drawn route path |
| Settings | Controls detection start delay and displays CCTV/cloud detection assumptions |

## Acceptance Criteria

| AC ID | FR ID | Given | When | Then |
|---|---|---|---|---|
| AC-VST-001 | FR-VST-001 | a student opens the app | the student taps Lamduan Mail sign-in | the app opens the vehicle tracking dashboard |
| AC-VST-002 | FR-VST-002 | the dashboard is open | vehicle data is available | the app shows E1 parking, CCTV marker, status, confidence, and last seen time |
| AC-VST-003 | FR-VST-003 | the Vehicle tab is open | the student taps a photo angle action | the selected angle changes state in the prototype |
| AC-VST-004 | FR-VST-004 | the Vehicle tab is open | the student edits and saves model/licence plate | the app confirms the saved values in the prototype |
| AC-VST-005 | FR-VST-005 | the History tab is open | the student selects a route log | the map-style view updates to that route path |
| AC-VST-006 | FR-VST-006 | the Settings tab is open | the student adjusts the delay range | the displayed delay range updates |

## Out Of Scope For Current Prototype

- Real MFU OAuth token exchange.
- Real Google Maps SDK/API key integration.
- Real Python backend endpoints.
- MongoDB schema and migrations.
- YOLOv11/ByteTrack model serving.
- Push notification delivery.
- Real image picker and file upload.

## Risks And Assumptions

| ID | Type | Description | Owner |
|---|---|---|---|
| A-VST-001 | Assumption | The provided MCP design token is not available through the current session resources, so the UI follows the written scope. | Frontend |
| A-VST-002 | Assumption | Google Maps will be integrated after API key, platform setup, and backend location contract are available. | Mobile/Backend |
| R-VST-001 | Risk | CCTV detection accuracy depends on daytime visibility and E1 camera coverage. | AI/Backend |
| R-VST-002 | Risk | Licence plate recognition needs privacy review and access control before production. | Security |
