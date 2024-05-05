import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/models/task.dart';
import '/app.dart';
import '/store/auth.dart';
import '/store/theme.dart';


Future<void> main() async {
  runApp(const Center(child: CircularProgressIndicator()));

  final container = ProviderContainer();
  await container.read(getUserProvider.future);
  await container.read(getThemeProvider.future);

  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  await Hive.openBox<Task>(tasksBoxName);
  await Hive.openBox<Note>(notesBoxName);
  // await Hive.openBox<Note>("project");


  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}
