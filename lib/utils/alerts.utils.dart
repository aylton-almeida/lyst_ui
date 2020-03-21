import 'package:flutter/material.dart';
import 'package:lystui/utils/textScale.utils.dart';

abstract class Alerts {
  static void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    List<AlertAction> actions,
  }) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title), content: Text(content), actions: actions
              .map((item) =>
              FlatButton(onPressed: item.action, child: Text(item.content)))
              .toList(),);
        });

  static void showSnackBar(
      {@required BuildContext context,
      @required String text,
      color,
      SnackBarAction action}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 6 + 8 * reducedTextScale(context)),
      ),
      backgroundColor: color ?? Colors.blueGrey,
      action: action,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}

class AlertAction {
  String content;
  Function action;

  AlertAction({this.content, this.action});
}
