import 'package:flutter/material.dart';
import 'package:lystui/utils/scaleUtils.dart';
import 'package:tinycolor/tinycolor.dart';

//Make sure you have a
abstract class Alerts {
  static void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    List<AlertAction> actions,
  }) =>
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: actions
                  .map((item) => FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        item.action();
                      },
                      child: Text(item.content)))
                  .toList(),
            );
          });

  static void showSnackBar(
      {@required BuildContext context,
      @required String text,
      color,
      SnackBarAction action}) {
    final tinyColor = TinyColor(color);
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(
            fontSize: 6 + 8 * ScaleUtils.of(context).reducedTextScale(),
            color: tinyColor.isLight() ? Colors.black : Colors.white),
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
