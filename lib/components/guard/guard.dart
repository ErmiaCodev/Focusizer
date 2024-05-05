import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/guide/guide.dart';
import '/store/auth.dart';

class Guard extends ConsumerWidget {
  Guard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (!user.loggedIn) {
      return GuidePage();
    }

    return child;
  }
}
