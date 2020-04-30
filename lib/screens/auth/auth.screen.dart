import 'package:flutter/material.dart';
import 'package:lystui/screens/auth/tabs/signin.tab.dart';
import 'package:lystui/screens/auth/tabs/signup.tab.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/keyboardDismissContainer.dart';

class AuthScreen extends StatefulWidget {
  static final routeName = '/signin';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Change the tabs here
  final tabs = <Tab>[
    Tab(text: 'SIGN IN'),
    Tab(text: 'SIGN UP'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundImage(
        child: KeyboardDismissContainer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png', width: 250),
                const SizedBox(height: 20),
                AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 350,
                    height: 450,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF28262C).withOpacity(0.6),
                    ),
                    child: DefaultTabController(
                      length: tabs.length,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(kToolbarHeight),
                          child: TabBar(
                            tabs: tabs,
                            indicatorColor: Theme.of(context).primaryColor,
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.white.withOpacity(0.8),
                            labelStyle: TextStyle(fontSize: 20),
                          ),
                        ),
                        body: TabBarView(
                          children: <Widget>[
                            SignInTab(),
                            SignUpTab(),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
