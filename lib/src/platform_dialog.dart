import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformDialog extends StatelessWidget {
  const PlatformDialog({
    required this.actionsBuilder,
    this.title,
    this.content,
    this.titlePadding,
    this.contentPadding,
    super.key,
  });

  final Widget? title;
  final Widget? content;
  final EdgeInsetsGeometry? titlePadding;
  final EdgeInsetsGeometry? contentPadding;
  final List<AdaptiveAction> Function(BuildContext context) actionsBuilder;

  static Future<T?> show<T>({
    required BuildContext context,
    required List<AdaptiveAction> Function(BuildContext context) actionsBuilder,
    bool barrierDismissible = true,
    RouteSettings? routeSettings,
    Widget? title,
    Widget? content,
    bool canPop = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      routeSettings: routeSettings,
      builder: (context) {
        return PopScope(
          canPop: canPop,
          child: PlatformDialog(
            title: title,
            content: content,
            actionsBuilder: actionsBuilder,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog.adaptive(
      titlePadding: titlePadding,
      contentPadding: contentPadding,
      title: switch (title) {
        final title? => DefaultTextStyle(
            textAlign: defaultTargetPlatform == TargetPlatform.iOS
                ? TextAlign.center
                : null,
            style: theme.textTheme.adaptiveDialogTitle(context),
            child: title,
          ),
        _ => null,
      },
      content: switch (content) {
        final content? => DefaultTextStyle(
            textAlign: defaultTargetPlatform == TargetPlatform.iOS
                ? TextAlign.center
                : null,
            style: theme.textTheme.adaptiveDialogContent(context),
            child: content,
          ),
        _ => null,
      },
      actions: actionsBuilder(context),
    );
  }
}

/// ios/android両対応のダイアログのアクション
/// see: https://api.flutter.dev/flutter/material/AlertDialog/AlertDialog.adaptive.html
class AdaptiveAction<T> extends StatelessWidget {
  const AdaptiveAction({
    required this.text,
    super.key,
    this.actionKey,
    this.isDefaultAction = false,
    this.iosOption = const IosAdaptiveActionOption(),
    this.androidOption = const AndroidAdaptiveActionOption(),
    this.returnValue,
  });

  final Key? actionKey;
  final bool isDefaultAction;
  final IosAdaptiveActionOption iosOption;
  final AndroidAdaptiveActionOption androidOption;
  final T? returnValue;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return switch (theme.platform) {
      TargetPlatform.iOS => CupertinoDialogAction(
          key: actionKey,
          textStyle: iosOption.textStyle,
          isDefaultAction: isDefaultAction,
          isDestructiveAction: iosOption.isDestructiveAction ?? false,
          onPressed: () => Navigator.of(context).pop(returnValue),
          child: text,
        ),
      TargetPlatform.android => TextButton(
          key: actionKey,
          style: isDefaultAction
              ? androidDialogButtonStyle(context)
              : androidOption.style,
          onPressed: () => Navigator.of(context).pop(returnValue),
          child: text,
        ),
      _ => throw UnimplementedError('Unsupported platform: ${theme.platform}'),
    };
  }
}

class IosAdaptiveActionOption {
  const IosAdaptiveActionOption({
    this.textStyle,
    this.isDestructiveAction,
  });

  final TextStyle? textStyle;
  // 赤いボタンになる
  final bool? isDestructiveAction;
}

class AndroidAdaptiveActionOption {
  const AndroidAdaptiveActionOption({
    this.style,
  });

  final ButtonStyle? style;
}

extension TextThemeExtension on TextTheme {
  TextStyle? get labelXLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  TextStyle get labelXLargeW600 =>
      labelXLarge!.copyWith(fontWeight: FontWeight.w600);

  TextStyle adaptiveDialogTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return defaultTargetPlatform == TargetPlatform.iOS
        ? labelXLargeW600.copyWith(color: colorScheme.onSurface)
        : headlineSmall!.copyWith(color: colorScheme.onSurface);
  }

  TextStyle adaptiveDialogContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return bodyMedium!.copyWith(
      color: defaultTargetPlatform == TargetPlatform.iOS
          ? colorScheme.onSurfaceVariant
          : colorScheme.onSurfaceVariant,
    );
  }
}

/// Androidのダイアログのボタンスタイル
///
/// フォントの問題である程度の文字サイズがないと、FontWeight600にした場合に漢字の文字が潰れる
ButtonStyle androidDialogButtonStyle(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return TextButton.styleFrom(
    foregroundColor: colorScheme.primary,
    disabledForegroundColor: colorScheme.primary.withOpacity(0.5),
  );
}
