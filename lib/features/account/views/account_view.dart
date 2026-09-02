import 'package:flutter/material.dart';

import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/coming_soon_dialog.dart';
import '../../../l10n/app_strings.dart';
import '../utils/account_metrics.dart';
import '../widgets/account_menu_item.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final m = AccountMetrics.of(context);
    final s = AppStrings.current;

    final items = <_AccountEntry>[
      _AccountEntry(
        iconPath: AppIcons.profile,
        title: s.editProfile,
        subtitle: s.editProfileSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.accountSettings,
        title: s.accountSettings,
        subtitle: s.accountSettingsSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.notification,
        title: s.notification,
        subtitle: s.notificationSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.appearance,
        title: s.appearance,
        subtitle: s.appearanceSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.helpAndFeedback,
        title: s.helpAndFeedback,
        subtitle: s.helpAndFeedbackSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.inviteFriend,
        title: s.inviteFriend,
        subtitle: s.inviteFriendSubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.privacySecurity,
        title: s.privacySecurity,
        subtitle: s.privacySecuritySubtitle,
      ),
      _AccountEntry(
        iconPath: AppIcons.subscription,
        title: s.subscription,
        subtitle: s.subscriptionSubtitle,
        showComingSoonBadge: true,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          bottom: false,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
              m.horizontalPadding,
              m.headerTop,
              m.horizontalPadding,
              m.navClearance,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isLast = index == items.length - 1;
              return Padding(
                // Same gap under every row (including before Subscription).
                padding: EdgeInsets.only(bottom: isLast ? 0 : m.rowGap),
                child: AccountMenuItem(
                  metrics: m,
                  iconPath: item.iconPath,
                  title: item.title,
                  subtitle: item.subtitle,
                  showComingSoonBadge: item.showComingSoonBadge,
                  onTap: item.showComingSoonBadge
                      ? null
                      : () => ComingSoonDialog.show(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AccountEntry {
  const _AccountEntry({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.showComingSoonBadge = false,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final bool showComingSoonBadge;
}
