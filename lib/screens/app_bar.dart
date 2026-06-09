import 'package:flutter/material.dart';

import 'map_screen.dart';
import 'setting_screen.dart';
import 'history_screen.dart';
import 'vehicle_screen.dart';

import '../data/demo_data.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({
    super.key,
    required this.selectedIndex,
    required this.detectionWindow,
    required this.onDestinationSelected,
    required this.onDetectionWindowChanged,
    required this.onLogout,
  });

  final int selectedIndex;
  final RangeValues detectionWindow;
  final ValueChanged<int> onDestinationSelected;
  final ValueChanged<RangeValues> onDetectionWindowChanged;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final profile = DemoTrackingData.vehicle;
    final tabs = <Widget>[
      MapScreen(profile: profile),
      const HistoryScreen(),
      // VehicleScreen(profile: profile),
      VehicleScreen(),
      SettingsScreen(
        detectionWindow: detectionWindow,
        onDetectionWindowChanged: onDetectionWindowChanged,
        onLogout: onLogout,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(index: selectedIndex, children: tabs),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 139, 15, 15),
          indicatorColor: const Color(0xFFB71C1C),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => const IconThemeData(color: Colors.white),
          ),
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Map',
            ),
            NavigationDestination(
              icon: Icon(Icons.route_outlined),
              selectedIcon: Icon(Icons.route),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.directions_car_outlined),
              selectedIcon: Icon(Icons.directions_car),
              label: 'Vehicle',
            ),
            NavigationDestination(
              icon: Icon(Icons.tune_outlined),
              selectedIcon: Icon(Icons.tune),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
