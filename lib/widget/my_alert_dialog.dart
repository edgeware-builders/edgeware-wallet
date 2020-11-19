import 'package:flutter/material.dart';
import 'package:wallet/wallet.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    @required this.title,
    @required this.content,
    this.actions,
    Key key,
  }) : super(key: key);

  final String title;
  final String content;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: AppColors.mainBackround,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      actions: actions,
    );
  }
}
