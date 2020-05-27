import 'package:flutter/material.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import './settings.screen.i18n.dart';

class AboutScreen extends StatefulWidget {
  static final routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'About us'.i18n,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/group.png',
                  width: 400,
                  height: 250,
                ),
                const SizedBox(height: 20),
                Text(
                  'This project was developed by students from the Software Engineering course at\nPUC Minas. Meet the team: '
                      .i18n,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                    title: Text('Amanda Lima',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    subtitle: Text('Developer'.gender(Gender.female),
                        style: TextStyle(fontSize: 13, color: Colors.white)),
                    leading: SizedBox(
                        height: 100.0,
                        width: 100.0, // fixed width and height
                        child: Image.asset('assets/images/aylton.png'))),
                ListTile(
                  title: Text('Aylton Almeida',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: Text('Developer'.gender(Gender.male),
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                  leading: SizedBox(
                      height: 100.0,
                      width: 100.0, // fixed width and height
                      child: Image.asset('assets/images/aylton.png')),
                ),
                ListTile(
                  title: Text('Lucca Romaniello',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: Text('Developer'.gender(Gender.male),
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                  leading: SizedBox(
                      height: 100.0,
                      width: 100.0, // fixed width and height
                      child: Image.asset('assets/images/aylton.png')),
                ),
                ListTile(
                  title: Text('Nayane Ornelas',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: Text('Developer'.gender(Gender.male),
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                  leading: SizedBox(
                      height: 100.0,
                      width: 100.0, // fixed width and height
                      child: Image.asset('assets/images/aylton.png')),
                ),
              ],
            ))),
      ),
    );
  }
}
