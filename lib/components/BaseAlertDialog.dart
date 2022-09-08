import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  String? _title;
  String? _content;
  String? _yes;
  String? _no;
  Function? _yesOnPressed;

  BaseAlertDialog(
      {required String title,
      required String content,
      required Function? yesOnPressed,
      String yes = "ACCEPT",
      String no = "CANCEL"}) {
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this._title!),
      content: new Text(this._content!),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new TextButton(
          child: Text(this._no!),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        new TextButton(
          child: new Text(this._yes!),
          onPressed: () {
            this._yesOnPressed!();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
