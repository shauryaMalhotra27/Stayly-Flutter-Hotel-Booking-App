import 'package:flutter/material.dart';
import 'package:flutter_hotel_booking_app/core/widgets/app_background.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const AppBackground(
        child: Center(child: Text('Dashboard Placeholder')),
      ),
    );
  }
}
