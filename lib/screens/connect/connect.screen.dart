import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lystui/widgets/backgroundImage.dart';

class ConnectScreen extends StatefulWidget {
  static final routeName = '/connect';

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  void _onConnectPress() {}

  void _onConnectEmailPress() {}

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(
              "Make lists\n"
              "Organize your ideas\n"
              "Accomplish your tasks\n"
              "Boost your productivity",
              style: TextStyle(color: Colors.white60, fontSize: 22.0),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'lib/assets/logo.png',
              width: 250,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 320,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/assets/icon_google.png',
                          width: 25,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "SIGN IN WITH GOOGLE",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    onPressed: _onConnectPress,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                          color: Colors.white, indent: 40, endIndent: 20),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.white60,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                            color: Colors.white, indent: 20, endIndent: 40)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 320,
                  child: OutlineButton(
                    textColor: Colors.white,
                    borderSide: BorderSide(color: Colors.white60, width: 2),
                    highlightedBorderColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.mail),
                        const SizedBox(width: 20),
                        Text(
                          "CONNECT WITH EMAIL",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                    onPressed: _onConnectEmailPress,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
