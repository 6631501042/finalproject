import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';

import '../models/tracking_models.dart';
import '../widgets/tracking_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Tracking',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF22312F),
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),

        actions: [
          // ---------- Profile (user) ----------
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton.filledTonal(
              tooltip: 'Profile',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              icon: const Icon(Icons.person_outline),
            ),
          ),
          // ---------- Bell (alerts) ----------
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton.filledTonal(
              tooltip: 'Alerts',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                );
              },
              icon: const Icon(Icons.notifications_active_outlined),
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          const TrackingMap(route: DemoTrackingData.currentRoute),

          const SizedBox(height: 16),

          _MetricGrid(profile: profile),
        ],
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = constraints.maxWidth > 520
            ? (constraints.maxWidth - 24) / 3
            : (constraints.maxWidth - 12) / 2;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _MetricTile(
              width: tileWidth,
              icon: Icons.confirmation_number_outlined,
              label: 'Licence Plate',
              value: profile.licensePlate,
            ),
            _MetricTile(
              width: tileWidth,
              icon: Icons.motorcycle_outlined,
              label: 'Vehicle Model',
              value: profile.model,
            ),
            _MetricTile(
              width: tileWidth,
              icon: Icons.location_on_outlined,
              label: 'Last Camera',
              value: profile.lastCamera,
            ),
            _MetricTile(
              width: tileWidth,
              icon: Icons.schedule_outlined,
              label: 'Saved Interval',
              value: '10 min',
            ),
          ],
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.width,
    required this.icon,
    required this.label,
    required this.value,
  });

  final double width;
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDDE8E3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF6A7A76),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF22312F),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
