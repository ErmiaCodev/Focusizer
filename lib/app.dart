import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskizer/pages/notes/note_add.dart';
import 'package:taskizer/pages/notes/notes_page.dart';
import 'package:taskizer/pages/tasks/tasks_page.dart';
import 'package:taskizer/pages/timer/timer.dart';
import '/pages/home/home_page.dart';
import '/pages/login/login.dart';
import '/store/auth.dart';
import '/store/theme.dart';


class SimpleApp extends StatelessWidget {
  SimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    // final authProvider = ref.watch(getUserProvider);
    // final themeState = ref.watch(getThemeProvider);
    // final themeMode = ref.watch(themeProvider);
    return Consumer(
      builder: (context, ref, child) {
        final themeState = ref.watch(getThemeProvider);
        final themeMode = ref.watch(themeProvider);

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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            fontFamily: 'Bach',
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.teal, background: Colors.blueGrey.shade900),
            hintColor: Colors.white,
            useMaterial3: true,
            fontFamily: 'Bach',
          ),
          themeMode: themeState.unwrapPrevious().when(
            data: (data) => themeMode ? ThemeMode.dark : ThemeMode.light,
            error: (_, __) => ThemeMode.light,
            loading: () => ThemeMode.system,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/notes': (context) => const NotesPage(),
            '/notes/add': (context) => AddNote(),
            '/tasks': (context) => TasksPage(),
            '/timer': (context) => TimerPage(),
            '/auth/login': (context) => LoginPage(),
          },
        );
      },
    );

    // return authProvider.unwrapPrevious().when(
    //   data: (data) {
    //     return MaterialApp(
    //       localizationsDelegates: const [
    //         GlobalCupertinoLocalizations.delegate,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //       ],
    //       supportedLocales: const [
    //         Locale("fa", "IR"),
    //       ],
    //       locale: const Locale("fa", "IR"),
    //       title: "Taskizer",
    //       debugShowCheckedModeBanner: false,
    //       theme: ThemeData(
    //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    //         fontFamily: 'Bach',
    //         useMaterial3: true,
    //       ),
    //       darkTheme: ThemeData(
    //         brightness: Brightness.dark,
    //         colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: Colors.teal, background: Colors.blueGrey.shade900),
    //         hintColor: Colors.white,
    //         useMaterial3: true,
    //         fontFamily: 'Bach',
    //       ),
    //       themeMode: themeState.unwrapPrevious().when(
    //             data: (data) => themeMode ? ThemeMode.dark : ThemeMode.light,
    //             error: (_, __) => ThemeMode.light,
    //             loading: () => ThemeMode.system,
    //           ),
    //       initialRoute: '/',
    //       routes: {
    //         '/': (context) => const HomePage(),
    //         '/notes': (context) => const NotesPage(),
    //         '/notes/add': (context) => AddNote(),
    //         '/tasks': (context) => TasksPage(),
    //         '/tasks/add': (context) => TaskAddPage(),
    //         '/timer': (context) => TimerPage(),
    //         '/auth/login': (context) => LoginPage(),
    //       },
    //     );
    //   },
    //   error: (Object error, StackTrace? stackTrace) {
    //     return Text('error: $error\nstackTrace: $stackTrace');
    //   },
    //   loading: () {
    //     return const CircularProgressIndicator();
    //   },
    // );
  }
}
