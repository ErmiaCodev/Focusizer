import 'package:flutter/material.dart';
import 'package:taskizer/styles/global.dart';

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
      height: 63,
      width: 110,
      child: FloatingActionButton(
        heroTag: 'action_btn_$label',
        backgroundColor: Colors.teal.shade300,
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 35),
            SizedBox(width: 4),
            Text(label, style: normTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
