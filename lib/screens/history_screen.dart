import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../models/tracking_models.dart';
import '../widgets/section_title.dart';
import '../widgets/tiny_badge.dart';
import '../widgets/tracking_map.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  RouteLog _selectedRoute = DemoTrackingData.routeLogs.first;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const SizedBox(height: 20),
        SectionTitle(
          title: 'Route History',
          actionLabel: 'Point A to B',
          icon: Icons.route_outlined,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(height: 20),
        TrackingMap(route: _selectedRoute),
        const SizedBox(height: 14),
        for (final route in DemoTrackingData.routeLogs) ...[
          _RouteLogTile(
            route: route,
            selected: route.id == _selectedRoute.id,
            onTap: () => setState(() => _selectedRoute = route),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _RouteLogTile extends StatelessWidget {
  const _RouteLogTile({
    required this.route,
    required this.selected,
    required this.onTap,
  });

  final RouteLog route;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: selected
          ? colorScheme.tertiary.withValues(alpha: 0.08)
          : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? colorScheme.tertiary.withValues(alpha: 0.35)
                  : const Color(0xFFDDE8E3),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // ---------- Route mini Map ---------- 
              // SizedBox(
              //   width: 88,
              //   child: TrackingMap(route: route, compact: true),
              // ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF22312F),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${route.startedAt} - ${route.endedAt}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF647571),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        TinyBadge(text: route.distance, icon: Icons.straighten),
                        TinyBadge(text: route.duration, icon: Icons.schedule),
                        TinyBadge(text: route.status, icon: Icons.sensors),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
