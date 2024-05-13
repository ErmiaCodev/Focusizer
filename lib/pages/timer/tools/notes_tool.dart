import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/pages/notes/note_detail.dart';
import 'package:taskizer/pages/timer/tools/note_preview.dart';
import 'package:taskizer/pages/timer/tools/tool_button.dart';

class NotesTool extends StatefulWidget {
  NotesTool({super.key});

  @override
  _NotesToolState createState() => _NotesToolState();
}

class _NotesToolState extends State<NotesTool> {
  Future<void> _onClick() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            // insetPadding: EdgeInsets.zero,
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            // clipBehavior: Clip.antiAlias,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("یاداشت ها"),
                FloatingActionButton.small(
                  backgroundColor: Colors.teal.shade300,
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/notes/add");
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
            content: Container(
              height: 200,
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Note>(notesBoxName).listenable(),
                builder: (context, Box<Note> box, child) {
                  if (box.values.isEmpty) {
                    return Text("یاداشتی وجود ندارد");
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...box.values.map((note) {
                          return ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      NoteDetailPage(note: note)));
                            },
                            child: Text(note.name),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToolButton(
        icon: Icons.sticky_note_2, label: "نوت ها", onPressed: _onClick);
  }
}
