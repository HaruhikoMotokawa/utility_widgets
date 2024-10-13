import 'package:flutter/material.dart';

/// アクションを選択するためのボトムシート
///
/// staticメソッド[show]を使って表示する
/// [show]メソッドの引数には[ActionItem]のリストを渡す
/// [ActionItem]はアイコン、テキスト、戻り値を持つ
/// 戻り値は[ActionBottomSheet]を表示した際に選択された[ActionItem]の戻り値
///
class ActionBottomSheet<T> extends StatelessWidget {
  const ActionBottomSheet({
    required this.actions,
    super.key,
  });

  final List<ActionItem> actions;

  static Future<T?> show<T>(
    BuildContext context, {
    required List<ActionItem<T>> actions,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) {
        return ActionBottomSheet<T>(actions: actions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListView(
        shrinkWrap: true,
        children: actions,
      ),
    );
  }
}

class ActionItem<T> extends StatelessWidget {
  const ActionItem({
    required this.icon,
    required this.text,
    this.returnValue,
    super.key,
  });

  final IconData icon;
  final String text;
  final T? returnValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),
        title: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        onTap: () => Navigator.pop(context, returnValue),
      ),
    );
  }
}
