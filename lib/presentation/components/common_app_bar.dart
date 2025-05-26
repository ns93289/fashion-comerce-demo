import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/tools.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;

  final Widget? title;

  final List<Widget>? actions;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final double? scrolledUnderElevation;

  final Color? shadowColor;

  final Color? surfaceTintColor;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final bool? centerTitle;

  final double? titleSpacing;

  final double? toolbarHeight;

  final double? leadingWidth;

  final TextStyle? toolbarTextStyle;

  final TextStyle? titleTextStyle;

  final SystemUiOverlayStyle? systemOverlayStyle;

  /// {@macro flutter.material.Material.clipBehavior}
  final Clip? clipBehavior;

  final EdgeInsetsGeometry? actionsPadding;

  const CommonAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.centerTitle = false,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.clipBehavior,
    this.actionsPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation ?? 5,
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor ?? colorShadow,
      surfaceTintColor: surfaceTintColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle ?? bodyStyle(color: colorText, fontWeight: FontWeight.w500),
      titleTextStyle: titleTextStyle ?? bodyStyle(color: colorText, fontWeight: FontWeight.w500),
      systemOverlayStyle:
          systemOverlayStyle ??
          SystemUiOverlayStyle(statusBarColor: colorPrimary, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark),
      clipBehavior: clipBehavior,
      actionsPadding: actionsPadding,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
