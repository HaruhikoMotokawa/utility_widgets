import 'package:flutter/material.dart';
import 'package:utility_widgets/utility_widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('スナックバーを表示'),
              // カスタマイズされたスナックバーはグローバル関数なので、以下のように呼び出す
              onPressed: () => showCustomSnackbar(context, 'スナックバーを表示しました'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('ボトムシートを表示'),
              onPressed: () async => onTapBottomSheetButton(context),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('ダイアログを表示'),
              onPressed: () async => onTapDialogButton(context),
            )
          ],
        ),
      ),
    );
  }
}

extension on HomeScreen {
  Future<void> onTapBottomSheetButton(BuildContext context) async {
    // [ActionBottomSheet]の[show]メソッドを使ってボトムシートを表示
    final result = await ActionBottomSheet.show<int>(
      context,
      actions: [
        // [ActionItem]はアイコン、テキスト、戻り値を持つ
        // タップした場合の挙動はボトムシートを閉じるのと同時にreturnValueに設定した値を返す
        const ActionItem(
          icon: Icons.add,
          text: '追加',
          returnValue: 0,
        ),
        const ActionItem(
          icon: Icons.edit,
          text: '編集',
          returnValue: 1,
        ),
        const ActionItem(
          icon: Icons.delete,
          text: '削除',
          returnValue: 2,
        ),
        // ボトムシート内はListViewになっているのでいるので、スクロールできるため
        // いくつでも追加できる
      ],
    );
    // 基本は以下のように受け取った値によって処理を分岐する書くことを前提にしている
    if (!context.mounted) return;

    switch (result) {
      case 0:
        showCustomSnackbar(context, '追加しました');
      case 1:
        showCustomSnackbar(context, '編集しました');
      case 2:
        showCustomSnackbar(context, '削除しました');
      // nullもあり得るので、その場合も考慮する
      case _:
        // 何もしない
        return;
    }
  }

  Future<void> onTapDialogButton(BuildContext context) async {
    // [PlatformDialog]の[show]メソッドを使ってダイアログを表示
    // [show]メソッドの引数には[AdaptiveAction]のリストを渡す
    final result = await PlatformDialog.show<int>(
      context: context,
      title: const Text('タイトル'),
      content: const Text('内容'),
      actionsBuilder: (context) => [
        // [AdaptiveAction]はテキスト、戻り値を持つ
        const AdaptiveAction(text: Text('キャンセル'), returnValue: 0),
        const AdaptiveAction(text: Text('OK'), returnValue: 1),
      ],
    );
    // 基本は以下のように受け取った値によって処理を分岐する書くことを前提にしている
    if (!context.mounted) return;

    switch (result) {
      case 0:
        showCustomSnackbar(context, 'キャンセルしました');
      case 1:
        showCustomSnackbar(context, 'OKしました');
      // nullもあり得るので、その場合も考慮する
      case _:
        // 何もしない
        return;
    }
  }
}
