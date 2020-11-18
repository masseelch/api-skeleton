import 'package:client/dialogs/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../generated/client/tag.dart';
import '../generated/model/tag.dart';
import '../widgets/drawer.dart';
import '../widgets/progress_indicators.dart';
import '../widgets/tag_display.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen();

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  List<Tag> _tags;

  @override
  void initState() {
    super.initState();

    TagClient.of(context)
        .list()
        .then((tags) => setState(() => _tags = tags))
        .catchError((err) {}); // todo - error handling
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final drawer = const AppDrawer();
    final appBar = AppBar(title: Text(t.screenTagsTitle));

    if (_tags == null) {
      return Scaffold(
        drawer: drawer,
        appBar: appBar,
        body: const CenteredCircularProgressIndicator(),
      );
    }

    return Scaffold(
      drawer: drawer,
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add),
        onPressed: () async {
          final tag = await showDialog<Tag>(
            context: context,
            builder: (_) => _EditTagDialog(
              tag: Tag()
                ..title = t.screenTagsDialogsAddDefaultTagTitle
                ..color = theme.accentColor,
            ),
          );

          if (tag != null) {
            setState(() {
              _tags.add(tag);
              _tags.sort((t1, t2) => t1.title.toLowerCase().compareTo(
                    t2.title.toLowerCase(),
                  ));
            });
          }
        },
      ),
      body: ListView.builder(
        itemCount: _tags.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: Align(
            alignment: Alignment.topLeft,
            child: TagDisplay(tag: _tags[index]),
          ),
        ),
      ),
    );
  }
}

class _EditTagDialog extends StatefulWidget {
  _EditTagDialog({@required this.tag}) : assert(tag != null);

  final Tag tag;

  @override
  _EditTagDialogState createState() => _EditTagDialogState();
}

class _EditTagDialogState extends State<_EditTagDialog> {
  final _focusScopeNode = FocusScopeNode();
  TextEditingController _titleController;

  Tag _tag;

  @override
  void initState() {
    _tag = widget.tag;

    _titleController = TextEditingController(text: _tag.title);
    super.initState();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(t.screenTagsDialogsAddTitle),
      actions: [
        FlatButton(
          child: Text(t.screenTagsDialogsAddContentColorDialogActionsOk),
          onPressed: () async {
            showLoadingDialog(context);

            try {
              final tag = await TagClient.of(context).create(_tag);

              Navigator.pop(context);
              Navigator.pop(context, tag);
            } catch (e, t) {
              Navigator.pop(context);
              rethrow;
              // todo - error handling
            }
          },
        ),
      ],
      content: FocusScope(
        node: _focusScopeNode,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: _titleController,
              onChanged: (v) {
                setState(() {
                  _tag.title = v;
                });
              },
              decoration: InputDecoration(
                labelText: t.screenTagsDialogsAddContentFieldLabelTitle,
              ),
            ),
            const SizedBox(height: 16),
            InputDecorator(
              decoration: InputDecoration(
                labelText: t.screenTagsDialogsAddContentFieldLabelColor,
              ),
              child: InkWell(
                child: TagDisplay(tag: _tag),
                onTap: () {
                  _focusScopeNode.nextFocus();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:
                          Text(t.screenTagsDialogsAddContentColorDialogTitle),
                      content: BlockPicker(
                        pickerColor: _tag.color,
                        onColorChanged: (c) {
                          setState(() {
                            _tag.color = c;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
