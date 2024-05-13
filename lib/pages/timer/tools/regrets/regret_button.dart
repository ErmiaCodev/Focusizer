import 'package:flutter/material.dart';
import 'package:taskizer/styles/global.dart';

class RegretButton extends StatelessWidget {
  const RegretButton({
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
      height: 55,
      width: 92,
      child: FloatingActionButton(
        heroTag: 'regret_btn_$label',
        backgroundColor: Colors.blueGrey.shade400,
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(width: 4),
            Text(label, style: normTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
