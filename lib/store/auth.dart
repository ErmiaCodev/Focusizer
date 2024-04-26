import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/models/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

  void updateLogin(String name) {
    state = state.copywith(name: name, loggedIn: true, guided: true);
  }

  void updateLogout() {
    state =
        state.copywith(name: "", loggedIn: false, guided: true, id: 0);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>(
    (ref) => UserNotifier(const User(name: '')));

final getUserProvider = FutureProvider<User>(
  (ref) async {
    const storage = FlutterSecureStorage();

    log('building getAuth');

    var username = await storage.read(key: 'token') ?? '';
    var user = User(name: username);

    if (username != '') {
      ref.read(userProvider.notifier).updateLogin(username);
    } else {
      ref.read(userProvider.notifier).updateLogout();
    }

    return user;
  },
);

final setLogoutProvider = FutureProvider<void>((ref) async {
  const storage = FlutterSecureStorage();

  log("loggin out");

  ref.read(userProvider.notifier).updateLogout();
  await storage.delete(key: 'token');
});
