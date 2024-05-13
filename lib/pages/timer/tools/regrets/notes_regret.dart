import 'package:flutter/material.dart';
import '/constants/timer.dart';
import '/pages/timer/tools/regrets/regret_button.dart';

class NotesRegret extends StatelessWidget {
  const NotesRegret({super.key});

  void _onClick(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('برای این قابلی به ${notes_required_coins} سکه نیاز دارید',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900)),
      backgroundColor: Colors.amber,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return RegretButton(
        icon: Icons.sticky_note_2,
        label: "نوت ها",
        onPressed: () => _onClick(context));
  }
}
