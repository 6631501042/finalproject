# MFU Vehicle Self-Tracking Mobile App

Flutter prototype for a VEHICLE SELF-TRACKING MOBILE APP SYSTEM for Mae Fah Luang University students.

## Current Prototype

- Lamduan Mail sign-in entry screen.
- Vehicle tracking dashboard for E1 parking.
- Map-style vehicle location view with CCTV markers, guard radius, and route path.
- Vehicle profile editing for model, licence plate, and four motorcycle photo angles.
- Route history view from Point A to Point B.
- Detection settings with default 1-2 minute CCTV detection start window.

## Planned Integrations

- MFU OAuth through Lamduan Mail.
- Google Maps mobile SDK.
- Python backend APIs.
- MongoDB persistence.
- YOLOv11 and ByteTrack cloud detection pipeline.

## Run

```bash
flutter pub get
flutter run
```

## Verify

```bash
flutter analyze
flutter test
```
