import 'package:biyi_app/widgets/kbd/kbd_style.dart';
import 'package:biyi_app/widgets/kbd/kbd_theme.dart';
import 'package:flutter/material.dart';
import 'package:reflect_colors/reflect_colors.dart';

export 'kbd_theme.dart';

/// Display keyboard button or keys combination
class Kbd extends StatefulWidget {
  const Kbd(
    this.label, {
    super.key,
    this.style,
    this.size,
  });

  final String label;

  final KbdStyle? style;
  final Size? size;

  @override
  State<Kbd> createState() => _KbdState();
}

class _KbdState extends State<Kbd> {
  @override
  Widget build(BuildContext context) {
    final KbdThemeData? themeData = KbdTheme.of(context);
    final KbdThemeData defaults = _KbdDefaults(context);
    KbdStyle mergedStyle =
        widget.style ?? themeData?.mediumStyle ?? const KbdStyle();

    final TextStyle textStyle =
        (mergedStyle.labelStyle ?? const TextStyle()).copyWith(
      color: themeData?.labelColor ?? defaults.labelColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto Mono',
      fontFamilyFallback: ['Roboto'],
      fontSize: 12,
    );

    return Container(
      constraints: BoxConstraints(
        minWidth: mergedStyle.size?.width ?? 0,
        minHeight: mergedStyle.size?.height ?? 22,
      ),
      decoration: BoxDecoration(
        color: themeData?.color ?? defaults.color,
        border: BorderDirectional(
          start: BorderSide(
            color: themeData?.borderColor ?? defaults.borderColor!,
            width: 1,
          ),
          top: BorderSide(
            color: themeData?.borderColor ?? defaults.borderColor!,
            width: 1,
          ),
          end: BorderSide(
            color: themeData?.borderColor ?? defaults.borderColor!,
            width: 1,
          ),
          bottom: BorderSide(
            color: themeData?.borderColor ?? defaults.borderColor!,
            width: 3,
          ),
        ),
        borderRadius: themeData?.borderRadius ??
            defaults.borderRadius ??
            BorderRadius.zero,
      ),
      child: Padding(
        padding: mergedStyle.padding ??
            const EdgeInsets.only(
              left: 4,
              right: 4,
            ),
        child: DefaultTextStyle(
          style: textStyle,
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _KbdDefaults extends KbdThemeData {
  _KbdDefaults(this.context) : super();

  final BuildContext context;

  late final ThemeData _theme = Theme.of(context);
  late final bool _isDark = _theme.brightness == Brightness.dark;

  @override
  get color =>
      _isDark ? ReflectColors.gray.shade500 : ReflectColors.gray.shade50;

  @override
  get borderColor =>
      _isDark ? ReflectColors.gray.shade300 : ReflectColors.gray.shade300;

  @override
  get labelColor =>
      _isDark ? ReflectColors.gray.shade50 : ReflectColors.gray.shade700;

  @override
  get smallStyle {
    return const KbdStyle(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      size: Size.square(12),
      labelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  get mediumStyle {
    return const KbdStyle(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      size: Size.square(14),
      labelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  get largeStyle {
    return const KbdStyle(
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      size: Size.square(16),
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}