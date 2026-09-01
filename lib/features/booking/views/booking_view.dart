import 'package:flutter/material.dart';

import '../../../core/widgets/app_background.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const AppBackground(
        child: Center(child: Text('Booking Placeholder')),
      ),
    );
  }
}
