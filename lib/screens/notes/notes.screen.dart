import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/category.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/providers/notes.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/screens/notes/editNote.screen.dart';
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

  bool _isAllNotesMode = true;

  //TODO: implement
  void _onFabPress() {}

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.categories);
    Navigator.pop(context);
  }

  //TODO: implement
  void _onSearchPress() {}

  void _onCardTap(Note note) =>
      Navigator.of(context).pushNamed(EditNote.routeName, arguments: note);

  Future<void> refreshNotes({bool show = true}) async {
    if (show) refreshKey.currentState?.show(atTop: true);

    try {
      final notesProvider = Provider.of<NotesProvider>(context, listen: false);

      if (_isAllNotesMode)
        await notesProvider.doGetAllNotes();
      else {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        await notesProvider
            .doGetCategoryNotes(categoryProvider.currentCategory.id);
      }
    } catch (e) {
      print(e);
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
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.5,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        children: notes.map((note) => _buildCard(note)).toList(),
      ),
    );
  }

  Widget _buildCard(Note note) {
    return Hero(
      tag: '${note.id}/${note.title}',
      child: Card(
        color: Color(note.categoryColor).withOpacity(0.6),
        elevation: 5,
        child: InkWell(
          onTap: () => _onCardTap(note),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    note.title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                Flexible(
                  child: Text(
                    note.content,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      NotesScreenArguments args = ModalRoute.of(context).settings.arguments;
      setState(() {
        return this._isAllNotesMode = args.isAllNotesMode;
      });
      refreshNotes(show: false);
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

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final noteProvider = Provider.of<NotesProvider>(context);

    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back), onPressed: _onBackPressed),
            title: _isAllNotesMode
                ? Text('All Notes')
                : Text(categoryProvider.currentCategory.title.capitalize()),
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

class NotesScreenArguments {
  bool isAllNotesMode;

  NotesScreenArguments({this.isAllNotesMode});
}
