import 'package:flutter/material.dart';

/// カスタマイズしたスナックバーを表示する
///
/// [message]はスナックバーに表示したいメッセージ
/// [duration]はスナックバーを表示する時間（デフォルトは2秒で設定）
void showCustomSnackbar(
  BuildContext context,
  String message, {
  int duration = 2,
}) {
  // スナックバーの設定
  final snackbar = SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      duration: Duration(seconds: duration),
      // スナックバーを浮かせる設定
      behavior: SnackBarBehavior.floating,
      // スナックバーの内部のテキストとスナックバーの外側のパディング
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 16),
      // スナックバーと画面とのマージン
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      // 角丸の設定
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: Colors.grey);

  // ScaffoldMessengerを使用してスナックバーを表示
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
