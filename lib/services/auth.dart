import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/store/auth.dart';

class AuthService {
  Future<void> logout(WidgetRef ref) async {
    final FlutterSecureStorage _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
    ref.read(userProvider.notifier).updateLogout();
  }
}
