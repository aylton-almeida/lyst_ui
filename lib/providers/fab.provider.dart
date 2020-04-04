import 'package:flutter/material.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/screens/app/app.screen.dart';

class FabProvider with ChangeNotifier {
  Map<TabItem, List<FabOptions>> fabOptions = {
    TabItem.categories: [
      FabOptions(
        icon: Icons.view_list,
        isVisible: true,
        onPress: () => print('categories'),
      )
    ],
    TabItem.settings: [FabOptions(isVisible: false)],
  };

  void addFabOptions(TabItem tabItem, FabOptions options) {
    this.fabOptions[tabItem].add(options);
    notifyListeners();
  }

  void removeFabOptions(TabItem tabItem) {
    this.fabOptions[tabItem].removeLast();
    notifyListeners();
  }
}
