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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            SizedBox(
              //height: 50,
              width: 320,
              child: Center(
                child: Column(
                  children: <Widget>[
                    new Text(
                      "make lists",
                      style: TextStyle(color: Colors.white60, fontSize: 22.0),
                    ),
                    new Text(
                      "organize your ideas",
                      style: TextStyle(color: Colors.white60, fontSize: 22.0),
                    ),
                    new Text(
                      "accomplish your tasks",
                      style: TextStyle(color: Colors.white60, fontSize: 22.0),
                    ),
                    new Text(
                      "boost your productivity",
                      style: TextStyle(color: Colors.white60, fontSize: 22.9),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(left: 40.0, top: 100),
              width: 320,
              height: 160.0,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("lib/assets/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 40,
                  width: 320,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(200.0)),
                    color: Colors.white70,
                    splashColor: Colors.pinkAccent,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: new EdgeInsets.only(left:5, right: 12),
                          padding: const EdgeInsets.only(left: 50),
                          width: 32,
                          height: 27.0,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage ("lib/assets/icon_google.png"),

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Text(
                      "CONNECT WITH GOOGLE   ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),

                    ),
                      ],
                    ),
                    onPressed: _onConnectPress,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 390,
                  child: Center(
                    child: Text(
                      '───────────── OR ─────────────',
                      style: TextStyle(color: Colors.white60),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 322,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                    color: Colors.transparent,
                    splashColor: Colors.pinkAccent,
                    child: Row(
                      children: <Widget>[
                        Divider(
                          indent: 10,
                        ),
                        Icon(Icons.local_post_office,
                            size: 30, color: Colors.white60),
                        Text(
                          "CONNECT WITH EMAIL",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 18.0,
                          ),
                        ),
                        Icon(Icons.arrow_forward,
                            size: 21, color: Colors.white60),
                      ],
                    ),
                    onPressed: _onConnectPress,
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
