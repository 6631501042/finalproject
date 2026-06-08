import 'package:flutter/material.dart';

import '../models/tracking_models.dart';

class TrackingMap extends StatelessWidget {
  const TrackingMap({super.key, required this.route, this.compact = false});

  final RouteLog route;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: compact ? 1.9 : 1.25,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _TrackingMapPainter(
                route: route,
                primary: colorScheme.primary,
                alert: const Color(0xFFE7A400),
              ),
            ),
            Positioned(
              left: 12,
              top: 12,
              child: _MapPill(
                icon: Icons.local_parking,
                label: 'E1 Parking',
                color: colorScheme.primary,
              ),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: _MapPill(
                icon: Icons.videocam,
                label: compact ? route.status : 'CCTV E1-03',
                color: const Color(0xFF234E70),
              ),
            ),
            if (!compact)
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: _MapStatusBar(route: route),
              ),
          ],
        ),
      ),
    );
  }
}

class _MapPill extends StatelessWidget {
  const _MapPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF263533),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapStatusBar extends StatelessWidget {
  const _MapStatusBar({required this.route});

  final RouteLog route;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF263533).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.two_wheeler, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    route.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${route.startedAt} - ${route.endedAt}  |  ${route.duration}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.74),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              route.status,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFFFFD166),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackingMapPainter extends CustomPainter {
  const _TrackingMapPainter({
    required this.route,
    required this.primary,
    required this.alert,
  });

  final RouteLog route;
  final Color primary;
  final Color alert;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFFEAF0EF);
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    _drawCampusBlocks(canvas, size);
    _drawRoads(canvas, size);
    _drawParkingZone(canvas, size);
    _drawRoute(canvas, size);
    _drawCamera(canvas, size, const MapPoint(0.32, 0.64), 'E1-01');
    _drawCamera(canvas, size, const MapPoint(0.52, 0.52), 'E1-02');
    _drawCamera(canvas, size, const MapPoint(0.70, 0.39), 'E1-03');
  }

  void _drawCampusBlocks(Canvas canvas, Size size) {
    final blockPaint = Paint()..color = const Color(0xFFDDE8E3);
    final darkBlockPaint = Paint()..color = const Color(0xFFC9D8D2);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.07,
          size.height * 0.10,
          size.width * 0.28,
          size.height * 0.18,
        ),
        const Radius.circular(8),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.70,
          size.height * 0.12,
          size.width * 0.22,
          size.height * 0.20,
        ),
        const Radius.circular(8),
      ),
      darkBlockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.09,
          size.height * 0.62,
          size.width * 0.18,
          size.height * 0.24,
        ),
        const Radius.circular(8),
      ),
      blockPaint,
    );
  }

  void _drawRoads(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.shortestSide * 0.08;

    final roadLinePaint = Paint()
      ..color = const Color(0xFFB9C9C4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5;

    final road = Path()
      ..moveTo(size.width * 0.08, size.height * 0.84)
      ..cubicTo(
        size.width * 0.28,
        size.height * 0.66,
        size.width * 0.44,
        size.height * 0.60,
        size.width * 0.55,
        size.height * 0.48,
      )
      ..cubicTo(
        size.width * 0.68,
        size.height * 0.34,
        size.width * 0.78,
        size.height * 0.26,
        size.width * 0.92,
        size.height * 0.16,
      );

    canvas.drawPath(road, roadPaint);
    canvas.drawPath(road, roadLinePaint);

    final branch = Path()
      ..moveTo(size.width * 0.26, size.height * 0.20)
      ..lineTo(size.width * 0.45, size.height * 0.40)
      ..lineTo(size.width * 0.58, size.height * 0.49);
    canvas.drawPath(branch, roadPaint);
    canvas.drawPath(branch, roadLinePaint);
  }

  void _drawParkingZone(Canvas canvas, Size size) {
    final zoneRect = Rect.fromLTWH(
      size.width * 0.54,
      size.height * 0.33,
      size.width * 0.30,
      size.height * 0.26,
    );
    final zonePaint = Paint()..color = primary.withValues(alpha: 0.13);
    final zoneBorderPaint = Paint()
      ..color = primary.withValues(alpha: 0.42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    canvas.drawRRect(
      RRect.fromRectAndRadius(zoneRect, const Radius.circular(8)),
      zonePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(zoneRect, const Radius.circular(8)),
      zoneBorderPaint,
    );

    _drawText(
      canvas,
      'E1',
      Offset(zoneRect.left + 12, zoneRect.top + 10),
      TextStyle(color: primary, fontWeight: FontWeight.w900, fontSize: 16),
    );
  }

  void _drawRoute(Canvas canvas, Size size) {
    if (route.points.isEmpty) {
      return;
    }

    final offsets = route.points.map((point) => _scale(point, size)).toList();
    final routePath = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (final offset in offsets.skip(1)) {
      routePath.lineTo(offset.dx, offset.dy);
    }

    final shadowPaint = Paint()
      ..color = primary.withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10;
    final routePaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 4;

    canvas.drawPath(routePath, shadowPaint);
    canvas.drawPath(routePath, routePaint);

    final vehiclePosition = offsets.last;
    final radiusPaint = Paint()..color = alert.withValues(alpha: 0.14);
    final radiusStroke = Paint()
      ..color = alert.withValues(alpha: 0.40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(vehiclePosition, size.shortestSide * 0.18, radiusPaint);
    canvas.drawCircle(vehiclePosition, size.shortestSide * 0.18, radiusStroke);
    _drawVehicle(canvas, vehiclePosition);
    _drawEndpoint(canvas, offsets.first, primary);
  }

  void _drawCamera(Canvas canvas, Size size, MapPoint point, String label) {
    final offset = _scale(point, size);
    final cameraPaint = Paint()..color = const Color(0xFF234E70);
    final cameraRingPaint = Paint()
      ..color = const Color(0xFF234E70).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(offset, 5, cameraRingPaint);
    canvas.drawCircle(offset, 5, cameraPaint);
    _drawText(
      canvas,
      label,
      Offset(offset.dx + 8, offset.dy - 7),
      const TextStyle(
        color: Color(0xFF234E70),
        fontSize: 10,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  void _drawVehicle(Canvas canvas, Offset offset) {
    final outerPaint = Paint()..color = Colors.white;
    final vehiclePaint = Paint()..color = primary;
    canvas.drawCircle(offset, 13, outerPaint);
    canvas.drawCircle(offset, 9, vehiclePaint);

    final iconPainter = TextPainter(
      text: const TextSpan(
        text: 'M',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    iconPainter.paint(
      canvas,
      Offset(
        offset.dx - iconPainter.width / 2,
        offset.dy - iconPainter.height / 2,
      ),
    );
  }

  void _drawEndpoint(Canvas canvas, Offset offset, Color color) {
    canvas.drawCircle(offset, 6, Paint()..color = Colors.white);
    canvas.drawCircle(offset, 4, Paint()..color = color);
  }

  Offset _scale(MapPoint point, Size size) {
    return Offset(point.x * size.width, point.y * size.height);
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _TrackingMapPainter oldDelegate) {
    return oldDelegate.route != route ||
        oldDelegate.primary != primary ||
        oldDelegate.alert != alert;
  }
}
