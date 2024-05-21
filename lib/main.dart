import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '/constants/db.dart';
import '/models/file.dart';
import '/models/music.dart';
import '/models/note.dart';
import '/models/task.dart';
import '/pages/splash/splash.dart';
import '/pages/timer/notifications/success.dart' as success;
import '/app.dart';
import '/store/auth.dart';
import '/store/theme.dart';


Future<void> main() async {
  runApp(MaterialApp(
    home: FutureSplash(),
  ));

  final container = ProviderContainer();
  await container.read(getUserProvider.future);
  await container.read(getThemeProvider.future);

  await success.initializeAwesome();

  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Note>(NoteAdapter());
  Hive.registerAdapter<UserFile>(UserFileAdapter());
  Hive.registerAdapter<Music>(MusicAdapter());
  await Hive.openBox<Task>(tasksBoxName);
  await Hive.openBox<Note>(notesBoxName);
  await Hive.openBox<UserFile>(filesBoxName);
  await Hive.openBox<Music>(musicsBoxName);
  await Hive.openBox(coinsBoxName);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}
