import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../../app/theme/app_icons.dart';
import '../../../core/widgets/coming_soon_dialog.dart';
import '../../../l10n/app_strings.dart';
import '../utils/side_menu_metrics.dart';
import 'side_menu_header.dart';
import 'side_menu_item.dart';
import 'side_menu_section_label.dart';

/// Keep in sync with [KFDrawer.minScale].
const double kDrawerContentMinScale = 0.86;

/// Pinned profile header.
class SideMenuPinnedHeader extends StatelessWidget {
  const SideMenuPinnedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final m = SideMenuMetrics.of(context);
    final size = MediaQuery.sizeOf(context);
    // Match top of scaled peek content.
    final peekTop = size.height * (1 - kDrawerContentMinScale) / 2;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        m.horizontalPadding,
        peekTop + m.topPadding,
        m.horizontalPadding,
        m.sectionGap,
      ),
      child: SideMenuHeader(
        metrics: m,
        onClose: () => KFDrawer.of(context)?.close(),
      ),
    );
  }
}

/// Scrollable menu body; min height keeps options top-aligned under the header.
class SideMenuItemsDrawerItem extends KFDrawerItem {
  const SideMenuItemsDrawerItem({super.key}) : super(closeOnTap: false);

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final m = SideMenuMetrics.of(context);
    final peekTop = screenH * (1 - kDrawerContentMinScale) / 2;
    final headerBlock = peekTop + m.topPadding + m.avatarSize + m.sectionGap;
    final minBodyHeight = (screenH - headerBlock).clamp(0.0, screenH);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minBodyHeight),
      child: const Align(
        alignment: Alignment.topCenter,
        child: SideMenuItemsBody(),
      ),
    );
  }
}

/// Side menu option rows.
class SideMenuItemsBody extends StatelessWidget {
  const SideMenuItemsBody({super.key});

  Future<void> _onItemTap(BuildContext context) async {
    final drawer = KFDrawer.of(context);
    await ComingSoonDialog.show(context);
    drawer?.close();
  }

  @override
  Widget build(BuildContext context) {
    final m = SideMenuMetrics.of(context);
    final s = AppStrings.current;

    Widget row(Widget child) => Padding(
      padding: EdgeInsets.only(right: m.itemTrailingInset),
      child: child,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        row(SideMenuSectionLabel(metrics: m)),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.notification,
            badgeText: s.sideMenuNotificationBadge,
            showChevron: false,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.itemGap),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuPayment,
            selected: true,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.itemGap),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuTranslate,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.itemGap),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuPrivacy,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.sectionGap),
        row(SideMenuSectionLabel(metrics: m)),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuListing,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.itemGap),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuHost,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.sectionGap),
        row(SideMenuSectionLabel(metrics: m)),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuDarkMode,
            showChevron: false,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: m.itemGap),
        row(
          SideMenuItem(
            metrics: m,
            iconPath: AppIcons.bell,
            label: s.sideMenuUpdate,
            onTap: () => _onItemTap(context),
          ),
        ),
        SizedBox(height: 24 * m.scale),
      ],
    );
  }
}
