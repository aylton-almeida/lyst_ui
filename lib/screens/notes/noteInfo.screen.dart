import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:provider/provider.dart';

class NoteInfo extends StatefulWidget {
  static final String routeName = '/noteinfo';

  @override
  _NoteInfoState createState() => _NoteInfoState();
}

class _NoteInfoState extends State<NoteInfo> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      provider.addFabOptions(
          TabItem.categories,
          FabOptions(
            icon: Icons.edit,
            isVisible: true,
            onPress: _onFabPress,
          ));
    });
  }

  //TODO: Implement
  void _onFabPress() {}

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.categories);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: BackgroundImage(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Hero(
            transitionOnUserGestures: true,
            tag: '${note.id}/${note.title}',
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Color(note.categoryColor).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: _onBackPressed,
                          ),
                          Text(
                            note.title,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          note.content,
                          style: TextStyle(
                              color: Colors.white, fontSize: 20, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
