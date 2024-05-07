import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskizer/pages/notes/note_add.dart';
import 'package:taskizer/pages/notes/notes_page.dart';
import 'package:taskizer/pages/tasks/task_add_page.dart';
import 'package:taskizer/pages/tasks/tasks_page.dart';
import '/pages/home/home_page.dart';
import '/pages/login/login.dart';
import '/store/auth.dart';
import '/store/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(getUserProvider);
    final themeState = ref.watch(getThemeProvider);
    final themeMode = ref.watch(themeProvider);

    return authProvider.unwrapPrevious().when(
      data: (data) {
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
            '/tasks/add': (context) => TaskAddPage(),
            '/auth/login': (context) => LoginPage(),
          },
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        return Text('error: $error\nstackTrace: $stackTrace');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
