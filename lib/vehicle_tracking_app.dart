import 'package:flutter/material.dart';

import 'data/demo_data.dart';
import 'screens/login_screen.dart';
import 'screens/app_bar.dart';
import 'theme/app_theme.dart';

class VehicleTrackingApp extends StatefulWidget {
  const VehicleTrackingApp({super.key});

  @override
  State<VehicleTrackingApp> createState() => _VehicleTrackingAppState();
}

class _VehicleTrackingAppState extends State<VehicleTrackingApp> {
  bool _isSignedIn = false;
  int _selectedIndex = 0;
  RangeValues _detectionWindow = const RangeValues(1, 2);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MFU Vehicle Tracker',
      theme: AppTheme.light,
      home: _isSignedIn
          ? AppBarScreen(
              selectedIndex: _selectedIndex,
              detectionWindow: _detectionWindow,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              onDetectionWindowChanged: (values) {
                setState(() => _detectionWindow = values);
              },
              onLogout: () {
                setState(() {
                  _isSignedIn = false;
                  _selectedIndex = 0;
                });
              },
            )
          : LoginScreen(
              vehicle: DemoTrackingData.vehicle,
              onSignedIn: () => setState(() => _isSignedIn = true),
            ),
    );
  }
}
