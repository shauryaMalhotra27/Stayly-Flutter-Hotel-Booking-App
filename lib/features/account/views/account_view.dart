import 'package:flutter/material.dart';

import '../../../core/widgets/app_background.dart';
import '../../../l10n/app_strings.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: Center(child: Text(AppStrings.current.accountPlaceholder)),
      ),
    );
  }
}
