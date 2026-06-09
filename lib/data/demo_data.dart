import '../models/tracking_models.dart';

class DemoTrackingData {
  const DemoTrackingData._();

  static const vehicle = UserProfile(
    ownerName: 'MFU_Student',
    email: '6631500000@lamduan.mfu.ac.th',
    model: 'Honda Wave 125i',
    licensePlate: 'AB 1234 Chiang Rai',
    parkingZone: 'E1 Parking Lot',
    currentStatus: 'Stationary inside guard radius',
    lastCamera: 'CCTV E1-03',
    lastSeen: '10:20 AM',
    confidence: '96%',
  );

  static const currentRoute = RouteLog(
    id: 'live-e1',
    title: 'Current parking position',
    startedAt: '10:10 AM',
    endedAt: '10:20 AM',
    distance: '0.0 km',
    duration: '10 min',
    status: 'Parked',
    points: [
      MapPoint(0.24, 0.78),
      MapPoint(0.34, 0.67),
      MapPoint(0.45, 0.56),
      MapPoint(0.55, 0.49),
      MapPoint(0.66, 0.43),
    ],
  );

  static const routeLogs = [
    RouteLog(
      id: 'route-001',
      title: 'E1 entrance to motorcycle row B',
      startedAt: '08:42 AM',
      endedAt: '08:49 AM',
      distance: '0.6 km',
      duration: '7 min',
      status: 'Detected by 3 cameras',
      points: [
        MapPoint(0.16, 0.80),
        MapPoint(0.25, 0.71),
        MapPoint(0.36, 0.65),
        MapPoint(0.48, 0.54),
        MapPoint(0.63, 0.42),
      ],
    ),
    RouteLog(
      id: 'route-002',
      title: 'Academic building to E1 parking',
      startedAt: 'Yesterday 04:12 PM',
      endedAt: 'Yesterday 04:24 PM',
      distance: '1.4 km',
      duration: '12 min',
      status: 'Last seen at E1-02',
      points: [
        MapPoint(0.82, 0.18),
        MapPoint(0.72, 0.27),
        MapPoint(0.58, 0.36),
        MapPoint(0.46, 0.52),
        MapPoint(0.64, 0.43),
      ],
    ),
    RouteLog(
      id: 'route-003',
      title: 'Library road to E1 parking',
      startedAt: 'Monday 01:10 PM',
      endedAt: 'Monday 01:21 PM',
      distance: '1.1 km',
      duration: '11 min',
      status: 'Complete route',
      points: [
        MapPoint(0.12, 0.20),
        MapPoint(0.25, 0.32),
        MapPoint(0.38, 0.45),
        MapPoint(0.53, 0.49),
        MapPoint(0.65, 0.43),
      ],
    ),
  ];

  static const detectionRules = [
    DetectionRule(
      title: 'CCTV coverage',
      value: 'E1 daytime only',
      detail: 'Detection pauses at night, in rain, and in fog.',
    ),
    DetectionRule(
      title: 'Stationary trigger',
      value: '1-2 min default',
      detail: 'The cloud detector starts after the vehicle is motionless.',
    ),
    DetectionRule(
      title: 'Save interval',
      value: 'Every 10 min',
      detail: 'Confirmed positions are stored as route history logs.',
    ),
    DetectionRule(
      title: 'Fallback location',
      value: 'Last camera',
      detail:
          'If the vehicle leaves camera range, the last detection remains visible.',
    ),
  ];
}
