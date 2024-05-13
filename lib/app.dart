import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskizer/pages/files/file_add.dart';
import 'package:taskizer/pages/files/files_page.dart';
import 'package:taskizer/pages/notes/note_add.dart';
import 'package:taskizer/pages/notes/notes_page.dart';
import 'package:taskizer/pages/shop/shop.dart';
import 'package:taskizer/pages/tasks/tasks_page.dart';
import 'package:taskizer/pages/timer/timer.dart';
import '/pages/home/home_page.dart';
import '/pages/login/login.dart';
import '/store/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"),
      ],
      locale: const Locale("fa", "IR"),
      title: "Taskizer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Bach',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          background: Colors.white,
          secondary: Colors.grey.shade100,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Bach',
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.teal,
            background: Colors.blueGrey.shade900,
            secondary: Colors.blueGrey.shade700,
            primary: Colors.white),
        hintColor: Colors.white,
      ),
      themeMode: (theme) ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/notes': (context) => const NotesPage(),
        '/notes/add': (context) => AddNote(),
        '/files': (context) => const FilesPage(),
        '/files/add': (context) => FileAddPage(),
        '/tasks': (context) => const TasksPage(),
        '/shop': (context) => const ShopPage(),
        '/timer': (context) => const TimerPage(),
        '/auth/login': (context) => const LoginPage(),
      },
    );
  }
}
