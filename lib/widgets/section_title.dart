import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.actionLabel,
    required this.icon,
    required this.color,
  });

  final String title;
  final String actionLabel;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(icon, color: color, size: 25),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 25,
              color: const Color(0xFF22312F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Chip(
          label: Text(actionLabel),
          visualDensity: VisualDensity.compact,
          side: BorderSide(color: color.withValues(alpha: 0.2)),
          backgroundColor: color.withValues(alpha: 0.08),
          labelStyle: TextStyle(color: color, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
