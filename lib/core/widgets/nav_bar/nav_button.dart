// Forked from google_nav_bar 5.0.7 (MIT License, Copyright (c) 2019 Soo Xiao Tong)
// https://pub.dev/packages/google_nav_bar
// Adds inactiveBackgroundColor and fixed pill/circle widths, and ports the
// original's layered per-property curves (icon color, label opacity, label
// inset) instead of one shared curve, to preserve its natural feel.
import 'dart:math' show pow;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({
    super.key,
    this.icon,
    this.iconSize,
    this.iconBuilder,
    this.fillsInactiveCircle = false,
    this.activeIconScale = 1.0,
    this.leading,
    this.iconActiveColor,
    this.iconColor,
    this.text,
    this.gap,
    this.color,
    this.inactiveColor,
    this.rippleColor,
    this.hoverColor,
    required this.onPressed,
    this.duration,
    this.curve,
    this.padding,
    this.margin,
    required this.active,
    this.borderRadius,
    this.textSize,
    this.labelMaxWidth,
    this.fixedLabelWidth,
    this.height,
    this.inactiveWidth,
    this.activeWidth,
  }) : assert(icon != null || iconBuilder != null || leading != null);

  final IconData? icon;
  final double? iconSize;
  final Text? text;
  final Widget? leading;

  /// Builds the icon with the animated color each frame (SVG / avatar).
  final Widget Function(Color color, double size)? iconBuilder;

  /// Avatar: expand to the inactive circle diameter instead of iconSize.
  final bool fillsInactiveCircle;

  /// Multiplier on iconSize when selected (avatars often want > 1).
  final double activeIconScale;
  final Color? iconActiveColor;
  final Color? iconColor;
  final Color? color;
  final Color? inactiveColor;
  final Color? rippleColor;
  final Color? hoverColor;
  final double? gap;
  final bool? active;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration? duration;

  /// Drives the pill's width reveal only; other sub-animations use fixed curves.
  final Curve? curve;
  final BorderRadius? borderRadius;
  final double? textSize;
  final double? labelMaxWidth;

  /// Fixed width for the active label slot, so every pill is the same width.
  final double? fixedLabelWidth;

  /// Explicit pill/circle height (needed since there's no FittedBox to bound it).
  final double? height;

  /// Explicit width for the inactive (circle) state, so width == height.
  final double? inactiveWidth;

  /// Explicit width for the active (pill) state, tweened by the AnimationController.
  final double? activeWidth;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.active! ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(NavButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = widget.duration;
    }
    if (widget.active! && _controller.status != AnimationStatus.completed) {
      _controller.forward();
    } else if (!widget.active! &&
        _controller.status != AnimationStatus.dismissed) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isActive = widget.active!;
    final width = isActive ? widget.activeWidth : widget.inactiveWidth;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        highlightColor: widget.hoverColor,
        splashColor: widget.rippleColor,
        borderRadius: widget.borderRadius,
        onTap: widget.onPressed,
        child: Container(
          padding: widget.margin,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value;

              // Width reveal, driven by the caller's curve. Clamped to [0,1]
              // because spring-like curves (elasticInOut, bounceOut, the
              // easeInOutBack family, ...) intentionally overshoot past
              // their nominal range — without clamping, the interpolated
              // width would briefly exceed activeWidth/inactiveWidth, which
              // overflows the Row laid out against that fixed bound.
              final widthT = (widget.curve ?? Curves.easeInOut)
                  .transform(t)
                  .clamp(0.0, 1.0);
              final currentWidth = width == null
                  ? null
                  : lerpDouble(
                      widget.inactiveWidth ?? width,
                      widget.activeWidth ?? width,
                      widthT,
                    );

              // Asymmetric expand/collapse curves, matching google_nav_bar's feel.
              final iconColorT = isActive
                  ? Curves.easeInExpo.transform(t)
                  : Curves.easeOutCirc.transform(t);
              final iconColor = Color.lerp(
                widget.iconColor,
                widget.iconActiveColor,
                iconColorT,
              );

              // Near-instant reveal on expand, plain easeIn on collapse.
              final labelOpacity = isActive
                  ? pow(t, 13).toDouble()
                  : Curves.easeIn.transform(t);

              final insetT = Curves.easeOutSine.transform(t);
              final labelLeftInset = (widget.gap ?? 0) + 8 - (8 * insetT);
              final labelRightInset = 8 * insetT;

              // Lerp padding with width — jumping padding on/off when
              // isActive flips overflows the Row mid-animation.
              final EdgeInsets endPadding = (widget.padding is EdgeInsets
                  ? widget.padding as EdgeInsets
                  : EdgeInsets.zero);
              // Tighter vertical inset so a scaled-up avatar still fits the pill.
              final effectiveEndPadding = widget.fillsInactiveCircle
                  ? EdgeInsets.fromLTRB(
                      endPadding.left * 0.6,
                      endPadding.top * 0.2,
                      endPadding.right,
                      endPadding.bottom * 0.2,
                    )
                  : endPadding;
              final resolvedPadding =
                  EdgeInsets.lerp(
                    EdgeInsets.zero,
                    effectiveEndPadding,
                    widthT,
                  ) ??
                  EdgeInsets.zero;

              final hasLabel = widget.text != null && widget.text!.data != '';
              final labelFootprint = hasLabel
                  ? ((widget.fixedLabelWidth ?? 0) +
                            labelLeftInset +
                            labelRightInset) *
                        widthT
                  : 0.0;

              final baseSize = widget.iconSize ?? 24;
              final diameter = widget.height ?? baseSize;
              final activeSize = (baseSize * widget.activeIconScale).clamp(
                baseSize,
                diameter,
              );
              var size = widget.fillsInactiveCircle
                  ? (lerpDouble(diameter, activeSize, widthT) ?? activeSize)
                  : baseSize;
              // Keep the icon inside the padded width so mid-animation
              // never trips a RenderFlex overflow.
              if (currentWidth != null) {
                final maxIcon =
                    (currentWidth - resolvedPadding.horizontal - labelFootprint)
                        .clamp(0.0, double.infinity);
                if (size > maxIcon) size = maxIcon;
              }

              final resolvedColor = iconColor ?? Colors.white;
              final icon =
                  widget.leading ??
                  widget.iconBuilder?.call(resolvedColor, size) ??
                  Icon(widget.icon, color: resolvedColor, size: size);

              Widget? label;
              if (hasLabel) {
                final text = widget.fixedLabelWidth != null
                    ? SizedBox(
                        width: widget.fixedLabelWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: widget.text,
                        ),
                      )
                    : widget.labelMaxWidth != null
                    ? ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: widget.labelMaxWidth!,
                        ),
                        child: widget.text,
                      )
                    : widget.text;

                // The label's total footprint (its own width plus both
                // insets) is driven by the same widthT that shrinks the
                // container, so it reaches exactly 0 as the animation
                // completes instead of being removed from the Row the
                // instant t hits 0 — that abrupt removal was what caused the
                // icon to visibly snap to center rather than glide there,
                // since the Row re-centers around whatever children remain.
                label = ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: 1.0,
                    child: SizedBox(
                      width: labelFootprint.clamp(0.0, double.infinity),
                      child: OverflowBox(
                        alignment: Alignment.centerLeft,
                        minWidth: 0,
                        maxWidth: double.infinity,
                        child: Opacity(
                          opacity: labelOpacity.clamp(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: labelLeftInset,
                              right: labelRightInset,
                            ),
                            child: text,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Hide the gray ring behind a full-bleed avatar.
              final bgColor = widget.fillsInactiveCircle && widthT < 0.5
                  ? Color.lerp(Colors.transparent, widget.color, widthT * 2)
                  : Color.lerp(widget.inactiveColor, widget.color, t);

              return Container(
                width: currentWidth,
                height: widget.height,
                padding: resolvedPadding,
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: widget.borderRadius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [icon, ?label],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
