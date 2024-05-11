import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({
    required this.color,
    required this.bgColor,
    required this.icon,
    required this.callback,
    super.key,
  });

  final Color bgColor;
  final Color color;
  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: const Offset(
            0.0,
            3.0
          ),
          blurRadius: 5.0,
          spreadRadius: 0.0,
        ), //BoxShadow
      ]),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => bgColor),
          foregroundColor:
              MaterialStateColor.resolveWith((states) => color),
        ),
        onPressed: () => callback(),
        icon: Icon(icon, size: 45),
      ),
    );
  }
}
