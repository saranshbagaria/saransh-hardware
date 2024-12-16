import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double width;
  final double radius;
  final double fontSize;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final Color? borderColor;
  final double borderWidth;
  final double opacity;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;
  final MainAxisAlignment contentAlignment;
  final bool isLoading;
  final Widget? loadingWidget;
  final bool enabled;
  final Duration? animationDuration;

  const ReusableButton({
    super.key,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
    this.width = double.infinity,
    this.radius = 8,
    this.fontSize = 15,
    this.elevation = 0,
    required this.onTap,
    this.onLongPress,
    this.leadingWidget,
    this.trailingWidget,
    this.borderColor,
    this.borderWidth = 1,
    this.opacity = 1,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.textStyle,
    this.contentAlignment = MainAxisAlignment.center,
    this.isLoading = false,
    this.loadingWidget,
    this.enabled = true,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color defaultBackgroundColor = theme.primaryColor;
    final Color effectiveBackgroundColor = backgroundColor ?? defaultBackgroundColor;
    final Color effectiveTextColor = textColor  ?? Colors.white;

    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.5,
      duration: animationDuration ?? Duration.zero,
      child: InkWell(
        onTap: enabled && !isLoading ? onTap : null,
        onLongPress: enabled && !isLoading ? onLongPress : null,
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(radius),
          color: Colors.transparent,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor.withOpacity(opacity),
              borderRadius: BorderRadius.circular(radius),
              border: borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth)
                  : null,
            ),
            child: Padding(
              padding: contentPadding,
              child: Row(
                mainAxisAlignment: contentAlignment,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingWidget != null) leadingWidget!,
                  if (leadingWidget != null) const SizedBox(width: 8),
                  if (isLoading)
                    loadingWidget ??
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                            strokeWidth: 2,
                          ),
                        )
                  else
                    Text(
                      title,
                      style: textStyle ??
                          TextStyle(
                            fontSize: fontSize,
                            color: effectiveTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  if (trailingWidget != null) const SizedBox(width: 8),
                  if (trailingWidget != null) trailingWidget!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}