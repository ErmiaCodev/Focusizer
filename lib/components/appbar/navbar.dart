import 'package:flutter/material.dart';
import '/styles/global.dart';

TextStyle appbarTitle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar(this.title, {super.key});

  final String title;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title, style: appbarTitle),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: brandGradient,
        ),
      ),
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
