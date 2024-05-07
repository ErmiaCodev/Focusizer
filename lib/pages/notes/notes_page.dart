import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/components/guard/guard.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/pages/notes/widgets/note_item.dart';
import 'package:taskizer/styles/global.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Guard(
        child: Scaffold(
      appBar: Navbar("یاداشت ها"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Note>(notesBoxName).listenable(),
          builder: (context, Box<Note> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text(
                  "!یاداشتی ای وجود ندارد",
                  style: titleStyle,
                  textDirection: TextDirection.ltr,
                ),
              );
            }

            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Note note = box.values.elementAt(index);
                return NoteItem(note: note, index: index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'notesList',
        onPressed: () {
          Navigator.of(context).pushNamed("/notes/add");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal.shade300,
        foregroundColor: Colors.white,
      ),
    ));
  }
}
