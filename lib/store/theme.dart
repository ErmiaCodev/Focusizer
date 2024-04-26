import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


final themeProvider = StateProvider((ref) => false);

final setThemeProvider = FutureProviderFamily<void, bool>((ref, mode) async {
  final prefs = await SharedPreferences.getInstance();
  ref.read(themeProvider.notifier).update((state) => mode);
  await prefs.setBool('dark', mode);
});


final toggleThemeProvider = FutureProvider((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final mode = ref.watch(themeProvider);
  ref.read(themeProvider.notifier).update((state) => !mode);
  await prefs.setBool('dark', !mode);
});


final getThemeProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();

  final theme = prefs.getBool('dark') ?? false;

  ref.read(themeProvider.notifier).update((state) => theme);

  return theme;
});
