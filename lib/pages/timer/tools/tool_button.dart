import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  const ToolButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 70,
      child: OverflowBox(
          maxHeight: 200,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 75,
            width: 20,
            child: FloatingActionButton.large(
              heroTag: "b_action_$label",
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal.shade400,
              onPressed: () => onPressed(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  SizedBox(height: 5),
                  Text(label,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          )),
    );
  }
}
