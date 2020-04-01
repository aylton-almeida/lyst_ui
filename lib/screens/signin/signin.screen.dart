import 'package:flutter/material.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/screens/home/home.screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static final routeName = '/signin';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
            child: Text('ENTRAR'),
            onPressed: () async {
              final authProvider =
                  Provider.of<AuthProvider>(context, listen: false);
              await authProvider.doSignInUser('almeida@aylton.dev', 'password');
              print(await authProvider.currentUser());
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }),
      ),
    );
  }
}
