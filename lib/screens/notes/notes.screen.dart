import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/category.model.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/providers/note.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';
import 'package:lystui/utils/string.extension.dart';

class NotesScreen extends StatefulWidget {
  static final routeName = '/notes';

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshNotes();
      final provider = Provider.of<FabProvider>(context, listen: false);
      provider.addFabOptions(
          TabItem.categories,
          FabOptions(
            icon: Icons.add,
            isVisible: true,
            onPress: _onFabPress,
          ));
    });
  }

  void _onFabPress() {}

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.categories);
    Navigator.pop(context);
  }

  void _onSearchPress() {}

  Future<void> refreshNotes() async {
    refreshKey.currentState?.show(atTop: false);
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    try {
      await Provider.of<NoteProvider>(context, listen: false)
          .doGetCategoryNotes(categoryProvider.currentCategory.id);
    } catch (e) {
      if (e is ServiceException && e.code != 'USER_NOT_CONNECTED')
        Alerts.showSnackBar(
            context: context,
            text: ErrorTranslator.noteError(e),
            color: Colors.red);
      else
        Alerts.showSnackBar(
            context: context,
            text: 'An error happened, please try again later',
            color: Colors.red);
    }
  }

  Widget _buildCategories(List<Note> notes) {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).primaryColor,
      color: Colors.white,
      key: refreshKey,
      onRefresh: refreshNotes,
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        children: notes
            .map((note) => Hero(
                  tag: '${note.title}',
                  child: Card(
                    elevation: 5,
                    child: Text('${note.title}'),
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final noteProvider = Provider.of<NoteProvider>(context);

    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back), onPressed: _onBackPressed),
            title: Text(categoryProvider.currentCategory.title.capitalize()),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: _onSearchPress)
            ],
          ),
          body: _buildCategories(noteProvider.notes),
        ),
      ),
    );
  }
}
