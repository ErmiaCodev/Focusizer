import 'package:flutter/material.dart';

@immutable
class User {
  final String name;
  final bool loggedIn;
  final bool guided;
  final int? id;

  const User({
    this.id,
    this.guided = false,
    this.loggedIn = false,
    required this.name,
  });

  User copywith({String? name, bool? loggedIn, bool? guided, int? id}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      loggedIn: loggedIn ?? this.loggedIn,
      guided: guided ?? this.guided,
    );
  }
}
