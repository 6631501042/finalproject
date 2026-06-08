import 'package:flutter/material.dart';

import '../widgets/inline_note.dart';
import '../widgets/section_title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.detectionWindow,
    required this.onDetectionWindowChanged,
    required this.onLogout,
  });

  final RangeValues detectionWindow;
  final ValueChanged<RangeValues> onDetectionWindowChanged;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rangeLabel =
        '${detectionWindow.start.round()}-${detectionWindow.end.round()} min';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  SectionTitle(
                    title: 'Detection Setting',
                    actionLabel: rangeLabel,
                    icon: Icons.tune_outlined,
                    color: colorScheme.primary,
                  ),

                  const SizedBox(height: 12),

                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFDDE8E3)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Detection start delay',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: const Color(0xFF22312F),
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                              ),
                              Text(
                                rangeLabel,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          DropdownButtonFormField<String>(
                            value: rangeLabel,
                            items: const [
                              DropdownMenuItem(
                                value: '1-2 min',
                                child: Text('1-2 min'),
                              ),
                              DropdownMenuItem(
                                value: '2-3 min',
                                child: Text('2-3 min'),
                              ),
                              DropdownMenuItem(
                                value: '3-4 min',
                                child: Text('3-4 min'),
                              ),
                              DropdownMenuItem(
                                value: '4-5 min',
                                child: Text('4-5 min'),
                              ),
                            ],
                            onChanged: (value) {
                              switch (value) {
                                case '1-2 min':
                                  onDetectionWindowChanged(
                                    const RangeValues(1, 2),
                                  );
                                  break;

                                case '2-3 min':
                                  onDetectionWindowChanged(
                                    const RangeValues(2, 3),
                                  );
                                  break;

                                case '3-4 min':
                                  onDetectionWindowChanged(
                                    const RangeValues(3, 4),
                                  );
                                  break;

                                case '4-5 min':
                                  onDetectionWindowChanged(
                                    const RangeValues(4, 5),
                                  );
                                  break;
                              }
                            },
                          ),

                          const SizedBox(height: 10),

                          const InlineNote(
                            icon: Icons.info_outline,
                            text:
                                'Default is 1-2 minutes before cloud CCTV detection starts.',
                            color: Color(0xFF234E70),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  _SettingsSwitchTile(
                    icon: Icons.warning_amber_rounded,
                    title: 'Movement alert',
                    value: true,
                    color: colorScheme.secondary,
                  ),

                  const SizedBox(height: 8),

                  _SettingsSwitchTile(
                    icon: Icons.wb_sunny_outlined,
                    title: 'Daytime CCTV mode',
                    value: true,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          // ------------------------------ Logout button ------------------------------
          FilledButton.icon(
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                onLogout();
              }
            },
            // ------------------------------ Logout button style ------------------------------
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: FilledButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSwitchTile extends StatefulWidget {
  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final bool value;
  final Color color;

  @override
  State<_SettingsSwitchTile> createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<_SettingsSwitchTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFDDE8E3)),
        ),
        child: SwitchListTile(
          value: _value,
          onChanged: (value) => setState(() => _value = value),
          secondary: Icon(widget.icon, color: widget.color),
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
