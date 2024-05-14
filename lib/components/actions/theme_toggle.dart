import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskizer/store/theme.dart';

class ThemeToggler extends StatelessWidget {
  const ThemeToggler({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          onPressed: () {
            ref.read(toggleThemeProvider);
          },
          icon: (Theme.of(context).brightness == Brightness.dark)
              ? const Icon(Icons.sunny)
              : const Icon(Icons.mode_night),
        );
      },
    );
  }
}
