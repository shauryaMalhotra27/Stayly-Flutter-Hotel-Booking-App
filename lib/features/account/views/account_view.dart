import 'package:flutter/material.dart';

import '../../../core/widgets/app_background.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: const AppBackground(
        child: Center(child: Text('Account Placeholder')),
      ),
    );
  }
}
