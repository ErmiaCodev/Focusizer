import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/components/guard/guard.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/file.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/pages/files/widgets/file_item.dart';
import 'package:taskizer/pages/notes/widgets/note_item.dart';
import 'package:taskizer/styles/global.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Guard(
        child: Scaffold(
      appBar: Navbar("فایل ها"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<UserFile>(filesBoxName).listenable(),
          builder: (context, Box<UserFile> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text(
                  "!فایلی وجود ندارد",
                  style: titleStyle,
                  textDirection: TextDirection.ltr,
                ),
              );
            }

            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                UserFile file = box.values.elementAt((box.values.length - index)-1);
                return FileItem(file: file, index: index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'filesList',
        onPressed: () {
          Navigator.of(context).pushNamed("/files/add");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal.shade300,
        foregroundColor: Colors.white,
      ),
    ));
  }
}
