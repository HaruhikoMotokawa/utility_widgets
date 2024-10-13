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
    final result = await ActionBottomSheet.show<int>(
      context,
      actions: [
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
      ],
    );
    if (!context.mounted) return;

    switch (result) {
      case 0:
        showCustomSnackbar(context, '追加しました');
      case 1:
        showCustomSnackbar(context, '編集しました');
      case 2:
        showCustomSnackbar(context, '削除しました');
      case _:
        // 何もしない
        return;
    }
  }

  Future<void> onTapDialogButton(BuildContext context) async {
    final result = await PlatformDialog.show<int>(
      context: context,
      title: const Text('タイトル'),
      content: const Text('内容'),
      actionsBuilder: (context) => [
        const AdaptiveAction(text: Text('キャンセル'), returnValue: 0),
        const AdaptiveAction(text: Text('OK'), returnValue: 1),
      ],
    );
    if (!context.mounted) return;

    switch (result) {
      case 0:
        showCustomSnackbar(context, 'キャンセルしました');
      case 1:
        showCustomSnackbar(context, 'OKしました');
      case _:
        // 何もしない
        return;
    }
  }
}
