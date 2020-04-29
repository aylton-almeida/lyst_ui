import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lystui/models/fabOptions.model.dart';
import 'package:lystui/models/note.model.dart';
import 'package:lystui/providers/fab.provider.dart';
import 'package:lystui/screens/app/app.screen.dart';
import 'package:lystui/utils/validators.utils.dart';
import 'package:lystui/widgets/backgroundImage.dart';
import 'package:lystui/widgets/keyboardDismissContainer.dart';
import 'package:lystui/widgets/personalizedTextField.dart';
import 'package:provider/provider.dart';

class EditNote extends StatefulWidget {
  static final String routeName = '/editnote';

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _contentController = TextEditingController();
  final _contentFocusNode = FocusNode();

  final _titleController = TextEditingController();
  final _titleFocusNode = FocusNode();

  Timer _debounce;

  bool _isEditMode = false;

  void _onNoteEdited() {
    //TODO: Implement
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  void _onBackPressed() {
    final fabProvider = Provider.of<FabProvider>(context, listen: false);
    fabProvider.removeFabOptions(TabItem.categories);
    Navigator.of(context).pop();
  }

  void _onDeletePressed() {
    //TODO: Implement
    // final noteProvider = Provider.of<AllNotesProvider>(context)
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FabProvider>(context, listen: false);
      provider.addFabOptions(TabItem.categories, FabOptions(isVisible: false));
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Note note = ModalRoute.of(context).settings.arguments;
    if (note != null) {
      _titleController.text = note.title;
      _contentController.text = note.content;
      setState(() {
        _isEditMode = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context).settings.arguments;

    return KeyboardDismissContainer(
      child: SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: _onBackPressed,
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: _onDeletePressed,
                                  color: Colors.white,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 18),
                                  child: _debounce?.isActive ?? false
                                      ? SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Icon(
                                          Icons.cloud_done,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: PersonalizedTextField(
                                  controller: _titleController,
                                  focusNode: _titleFocusNode,
                                  hintText: 'Note Title',
                                  autocorrect: true,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textCapitalization: TextCapitalization.words,
                                  validator: Validators.require,
                                  showBorder: false,
                                  showError: false,
                                  fontSize: 24,
                                  onChanged: (_) => _onNoteEdited(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: PersonalizedTextField(
                            controller: _contentController,
                            focusNode: _contentFocusNode,
                            hintText: 'Content',
                            autocorrect: true,
                            cursorColor: Theme.of(context).primaryColor,
                            textInputAction: TextInputAction.newline,
                            textCapitalization: TextCapitalization.words,
                            validator: Validators.require,
                            showBorder: false,
                            showError: false,
                            fontSize: 20,
                            onChanged: (_) => _onNoteEdited(),
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
      ),
    );
  }
}
