import 'package:flutter/material.dart';
import 'package:lystui/routes.dart';
import 'package:lystui/screens/home/widgets/destinationView/destinationView.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavItem = 0;

  void _onFloatingActionButtonPress() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _currentNavItem,
          children: Routes.subRoutes
              .map((route) => DestinationView(destination: route))
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF28262c),
          items: Routes.subRoutes
              .map((route) => BottomNavigationBarItem(
                  icon: Icon(route.icon), title: Text(route.title)))
              .toList(),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentNavItem,
          showUnselectedLabels: false,
          onTap: (item) {
            setState(() {
              _currentNavItem = item;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onFloatingActionButtonPress,
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
