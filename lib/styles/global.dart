import 'package:flutter/material.dart';

final brandGradient = LinearGradient(
  colors: <Color>[Colors.teal.shade500, Colors.cyan.shade600],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);


const labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
);


const titleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  // color: Colors.blueGrey.shade700,
);

final itemBoxStyle = BoxDecoration(
    color: Colors.teal.shade50,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    border: Border.all(color: Colors.teal.shade200)
);