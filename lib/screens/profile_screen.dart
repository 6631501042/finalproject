import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 40, //55
              backgroundColor: colorScheme.primary.withOpacity(0.15),
              child: const Icon(
                Icons.person,
                size: 50, //60
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'MFU_Student',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Student',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            _ProfileInfoCard(
              icon: Icons.person_outline,
              title: 'Username',
              value: 'MFU_Student',
            ),

            const SizedBox(height: 12),

            _ProfileInfoCard(
              icon: Icons.email_outlined,
              title: 'Email',
              value: '6631500000@lamduan.mfu.ac.th',
            ),

            const SizedBox(height: 12),

            _ProfileInfoCard(
              icon: Icons.badge_outlined,
              title: 'Student ID',
              value: '6631500000',
            ),

            const SizedBox(height: 12),

            _ProfileInfoCard(
              icon: Icons.phone_outlined,
              title: 'Phone Number',
              value: '087-666-1020',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDDE8E3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}