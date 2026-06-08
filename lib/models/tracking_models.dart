class UserProfile {
  const UserProfile({
    required this.ownerName,
    required this.email,
    required this.model,
    required this.licensePlate,
    required this.parkingZone,
    required this.currentStatus,
    required this.lastCamera,
    required this.lastSeen,
    required this.confidence,
  });

  final String ownerName;
  final String email;
  final String model;
  final String licensePlate;
  final String parkingZone;
  final String currentStatus;
  final String lastCamera;
  final String lastSeen;
  final String confidence;
}

class MapPoint {
  const MapPoint(this.x, this.y);

  final double x;
  final double y;
}

class RouteLog {
  const RouteLog({
    required this.id,
    required this.title,
    required this.startedAt,
    required this.endedAt,
    required this.distance,
    required this.duration,
    required this.status,
    required this.points,
  });

  final String id;
  final String title;
  final String startedAt;
  final String endedAt;
  final String distance;
  final String duration;
  final String status;
  final List<MapPoint> points;
}

class DetectionRule {
  const DetectionRule({
    required this.title,
    required this.value,
    required this.detail,
  });

  final String title;
  final String value;
  final String detail;
}
