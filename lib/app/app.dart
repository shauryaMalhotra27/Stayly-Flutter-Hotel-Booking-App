import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import '../l10n/app_strings.dart';

/// The root application widget setting up MaterialApp.router.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.current.appTitle,
      theme: AppTheme.theme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
