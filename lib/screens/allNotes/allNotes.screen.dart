import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/models/serviceException.model.dart';
import 'package:lystui/providers/allNotes.provider.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/utils/alerts.utils.dart';
import 'package:lystui/utils/errorTranslator.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/privateRoute.dart';
import 'package:provider/provider.dart';

class AllNotes extends StatefulWidget {
  static final routeName = '/allNotes';

  @override
  _AllNotesState createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
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

  //TODO: implement
  void _onFabPress() {}

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.categories);
    Navigator.pop(context);
  }

  //TODO: implement
  void _onSearchPress() {}

  //TODO: implement
  void _onCardTap(Note note) {}

  Future<void> refreshNotes({bool show = true}) async {
    if (show) refreshKey.currentState?.show(atTop: true);

    try {
      await Provider.of<AllNotesProvider>(context, listen: false).doGetAllNotes();
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

  Widget _buildNotes(List<Note> notes) {
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
      tag: note.title,
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
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<AllNotesProvider>(context);

    return PrivateRoute(
      child: BackgroundImage(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back), onPressed: _onBackPressed),
            title: Text('All Notes'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: _onSearchPress)
            ],
          ),
          body: _buildNotes(noteProvider.allNotes),
        ),
      ),
    );
  }
}
