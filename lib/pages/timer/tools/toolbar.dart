import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/constants/timer.dart';
import 'package:taskizer/pages/timer/tools/files_tool.dart';
import 'package:taskizer/pages/timer/tools/notes_tool.dart';
import 'package:taskizer/pages/timer/tools/regrets/files_regret.dart';
import 'package:taskizer/pages/timer/tools/regrets/notes_regret.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  Widget build(BuildContext) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      left: 0,
      child: ValueListenableBuilder(
        valueListenable: Hive.box(coinsBoxName).listenable(),
        builder: (context, Box box, child) {
          final coins = box.get('coins') ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (coins >= notes_required_coins) ? NotesTool() : NotesRegret(),
              (coins >= files_required_coins) ? FilesTool() : FilesRegret(),
            ],
          );
        },
      ),
    );
  }
}