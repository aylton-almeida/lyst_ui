import 'package:flutter/material.dart';
import 'package:lystui/providers/auth.provider.dart';
import 'package:lystui/routes.dart';
import 'package:lystui/screens/home/widgets/destinationView/destinationView.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavItem = 0;

  void _onFloatingActionButtonPress() async {
    //Define here the FAB behavior
    //TODO: Put correct action
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
//      await authProvider.doSignUpUser('almeida@aylton.dev', 'password');
//      await authProvider.doSignInUser('almeida@aylton.dev', 'password');
      print(await authProvider.currentUser());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Define here the FAB appearance
    IconData _fabIcon = Icons.view_list;
    bool _isFabShown = true;
    if (_currentNavItem == 0) {
      _isFabShown = true;
      _fabIcon = Icons.view_list;
    } else
      _isFabShown = false;

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
        floatingActionButton: _isFabShown
            ? FloatingActionButton(
                onPressed: _onFloatingActionButtonPress,
                child: Icon(_fabIcon),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
