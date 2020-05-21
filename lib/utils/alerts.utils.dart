import 'package:flutter/material.dart';
import 'package:lystui/utils/scaleUtils.dart';
import 'package:tinycolor/tinycolor.dart';

//Make sure you have a
abstract class Alerts {
  static void showAlertDialog({
    @required BuildContext context,
    @required String title,
    @required String content,
    Color backgroundColor,
    List<AlertAction> actions,
  }) =>
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: backgroundColor,
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              content: Text(content, style: TextStyle(color: Colors.white)),
              actions: actions
                  .map((item) => FlatButton(
                      splashColor: item.color,
                      onPressed: () {
                        Navigator.of(context).pop();
                        item.action();
                      },
                      child: Text(
                        item.content,
                        style: TextStyle(color: item.color),
                      )))
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
  Color color;

  AlertAction({this.content, this.action, this.color});
}
