import 'package:flutter/material.dart';
import 'package:lystui/widgets/backgorundImageWidget/backgroundImage.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavITem = 0;

  final _itemList = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text("Settings"),
    )
  ];

  void _onFloatingActionButtonPress() {}

  void _onNavItemTap(int currItem) {}

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lyst"),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Text("Hello World"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFloatingActionButtonPress,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          items: _itemList,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: _onNavItemTap,
          backgroundColor: Color(0xFF28262c),
          type: BottomNavigationBarType.shifting,
        ),
      ),
    );
  }
}
