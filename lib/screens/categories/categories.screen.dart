import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/notes/notes.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';
import 'package:lystui/utils/string.extension.dart';

class CategoriesScreen extends StatefulWidget {
  static final routeName = '/';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  void _onFabPress() => Navigator.of(context).pushNamed(NotesScreen.routeName,
      arguments: NotesScreenArguments(isAllNotesMode: true));

  void _onCategoryPress(Category category) {
    Provider.of<CategoryProvider>(context, listen: false)
        .setCurrentCategory(category);
    Navigator.pushNamed(context, NotesScreen.routeName,
        arguments: NotesScreenArguments(isAllNotesMode: false));
  }

  Future<void> refreshCategories() async {
    refreshKey.currentState?.show(atTop: false);

    try {
      await Provider.of<CategoryProvider>(context, listen: false)
          .doUpdateCategories();
    } catch (e) {
      print(e);
      if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.authError(e),
            color: Colors.red);
      else
        Alerts.showSnackBar(
            context: context,
            text: 'An error happened, please try again later',
            color: Colors.red);
    }
  }

  Widget _buildCategories(List<Category> categories) {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      color: Colors.white,
      key: refreshKey,
      onRefresh: refreshCategories,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        itemCount: categories.length,
        itemBuilder: (context, i) => _buildRow(categories[i]),
      ),
    );
  }

  Widget _buildRow(Category category) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: Color(category.color),
            shape: BoxShape.circle,
          ),
        ),
      ),
      title: Text(
        category.title.capitalize(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      trailing: Text(
        '${category.notesCount}',
        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
      ),
      onTap: () => _onCategoryPress(category),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshCategories();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      if (provider.fabOptions[TabItem.categories].length == 1)
        provider.addFabOptions(
            TabItem.categories,
            FabOptions(
              icon: Icons.view_list,
              isVisible: true,
              onPress: _onFabPress,
            ));
    });
  }

  @override
  void dispose() {
    refreshKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            width: 100,
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
