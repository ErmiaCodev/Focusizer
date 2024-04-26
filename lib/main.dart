import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/app.dart';
import '/store/auth.dart';
import '/store/theme.dart';

Future<void> main() async {
  runApp(const Center(child: CircularProgressIndicator()));

  final container = ProviderContainer();
  await container.read(getUserProvider.future);
  await container.read(getThemeProvider.future);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const App(),
  ));
}
