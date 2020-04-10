import 'package:flutter/material.dart';

class DialogManager {
  static Future<Widget> showConfirmationDialog(
          BuildContext context, String content, Function acceptCallback) =>
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: acceptCallback,
            ),
          ],
        ),
      );

  static Future<Widget> showInformationDialog(BuildContext context, String content) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
