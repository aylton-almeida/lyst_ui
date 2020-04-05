import 'package:flutter/material.dart';
import 'package:lystui/models/destination.model.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/widgets/tabNavigator/tabNavigator.dart';
import 'package:provider/provider.dart';

enum TabItem { categories, settings }

class AppScreen extends StatefulWidget {
  static final routeName = "/app";

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  TabItem _currentTab = TabItem.categories;

  Map<TabItem, Destination> destinations = {
    TabItem.categories: Destination(
      title: "Home",
      icon: Icons.home,
    ),
    TabItem.settings: Destination(
      title: "Settings",
      icon: Icons.settings,
    ),
  };

  void _selectTab(int index) {
    setState(() {
      _currentTab = TabItem.values[index];
    });
  }

  Widget _buildOffStateNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: destinations[tabItem].navigatorKey,
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fabProvider = Provider.of<FabProvider>(context);
    final fabOptions = fabProvider.fabOptions[_currentTab].last;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          fabProvider.removeFabOptions(_currentTab);
          return !await destinations[_currentTab]
              .navigatorKey
              .currentState
              .maybePop();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              _buildOffStateNavigator(TabItem.categories),
              _buildOffStateNavigator(TabItem.settings),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFF28262c),
            items: destinations.values
                .map((destination) => BottomNavigationBarItem(
                    icon: Icon(destination.icon),
                    title: Text(destination.title)))
                .toList(),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentTab.index,
            showUnselectedLabels: false,
            onTap: _selectTab,
          ),
          floatingActionButton: fabOptions.isVisible
              ? FloatingActionButton(
                  onPressed: fabOptions.onPress,
                  child: Icon(fabOptions.icon),
                  backgroundColor: Theme.of(context).primaryColor,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
