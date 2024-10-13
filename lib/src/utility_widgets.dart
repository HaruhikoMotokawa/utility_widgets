import 'package:flutter/material.dart';
import 'package:utility_widgets/src/action_bottom_sheet.dart';
import 'package:utility_widgets/src/custom_snack_bar.dart';

/// UtilityWidgets class
class UtilityWidgets {
  const UtilityWidgets();

  /// カスタマイズしたスナックバーを表示する
  void showUtilitySnackbar(BuildContext context, String message,
          {int duration = 2}) =>
      showCustomSnackbar(context, message, duration: duration);

  /// ボトムシートの原型
  ///
  Future<void> showActionBottomSheet(
    BuildContext context, {
    required List<ActionItem> actions,
  }) async {
    // Flutter標準のボトムシートの関数を呼び出す
    // 細かな設定はここで行う
    // 引数のbuilderに[ActionBottomSheet]を返す
    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) {
        // 引数のactionsはここではなくて呼び出し元で設定するので、
        // [showActionBottomSheet]の引数にする
        return ActionBottomSheet(actions: actions);
      },
    );
  }
}
