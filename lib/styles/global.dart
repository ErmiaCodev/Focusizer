import 'package:flutter/material.dart';

final brandGradient = LinearGradient(
  colors: <Color>[Colors.teal.shade500, Colors.cyan.shade600],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

final darkGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[Colors.cyan.shade900, Colors.blueGrey.shade700],
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

const normTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.normal,
);
