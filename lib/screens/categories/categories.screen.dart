import 'package:flutter/material.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';
import 'package:lystui/utils/string.extension.dart';

class CategoriesScreen extends StatefulWidget {
  static final routeName = '/';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshCategories();
  }

  @override
  void dispose() {
    refreshKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> refreshCategories() async {
    refreshKey.currentState?.show(atTop: false);

    try {
      await Provider.of<CategoryProvider>(context, listen: false)
          .doUpdateCategories();
    } catch (e) {
      if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.authError(e),
            color: Colors.red);
      else
        Alerts.showSnackBar(
            context: context,
            text: 'Ocorreu um erro, tente novamente mais tarde',
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
        child: Hero(
          tag: 'colorCircle:${category.color}',
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Color(category.color),
              shape: BoxShape.circle,
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoryProvider>(context);

    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'lib/assets/logo.png',
              width: 100,
            ),
            centerTitle: true,
          ),
          body: _buildCategories(categoriesProvider.categories),
        ),
      ),
    );
  }
}
