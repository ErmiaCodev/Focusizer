import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/file.dart';
import 'package:taskizer/models/note.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/styles/global.dart';
import '/components/guard/guard.dart';
import '/store/auth.dart';
import '/store/theme.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  // final _auth = AuthService();

  void _deleteHiveData() async {
    final tasksBox = Hive.box<Task>(tasksBoxName);
    final notesBox = Hive.box<Note>(notesBoxName);
    final filesBox = Hive.box<UserFile>(filesBoxName);
    final coinsBox = Hive.box(coinsBoxName);

    tasksBox.clear();
    notesBox.clear();
    filesBox.clear();
    coinsBox.clear();
  }

  Future<void> _onLogout(BuildContext context, WidgetRef ref) async {
    _deleteHiveData();

    const storage = FlutterSecureStorage();
    ref.read(userProvider.notifier).updateLogout();
    await storage.delete(key: 'token');

    if (Navigator.of(context).canPop()) {
      Navigator.pop(context);
    }

    Navigator.of(context).pushReplacementNamed('/auth/login');
  }

  Future<void> _onThemeToggle(BuildContext context, WidgetRef ref) async {
    await ref.read(toggleThemeProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Guard(
          child: Column(
        children: [
          const Expanded(flex: 2, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final user = ref.read(userProvider);

                    return Column(
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () => _onThemeToggle(context, ref),
                              heroTag: 'follow',
                              elevation: 0,
                              backgroundColor: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.orange.shade300
                                  : Colors.indigo.shade300,
                              foregroundColor: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? Colors.black
                                  : Colors.white,
                              label: Text(
                                (Theme.of(context).brightness ==
                                        Brightness.dark)
                                    ? "حالت روز"
                                    : "حالت شب",
                                style: normTextStyle,
                              ),
                              icon: const Icon(Icons.nightlight),
                            ),
                            const SizedBox(width: 16.0),
                            FloatingActionButton.extended(
                              onPressed: () => _onLogout(context, ref),
                              heroTag: 'logout',
                              elevation: 0,
                              backgroundColor: Colors.red.shade300,
                              label: const Text("خروج", style: normTextStyle),
                              icon: const Icon(Icons.exit_to_app),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const _ProfileInfoRow()
                      ],
                    );
                  },
                )),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan.shade300,
        child: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box<Task>(tasksBoxName).listenable(),
                  builder: (context, Box<Task> box, child) {
                    if (box.isEmpty) {
                      return Expanded(
                        child: _singleItem(
                          context,
                          const ProfileInfoItem("پروسه ها", 0),
                        ),
                      );
                    }

                    return Expanded(
                      child: _singleItem(
                        context,
                        ProfileInfoItem("پروسه ها", box.values.length),
                      ),
                    );
                  },
                ),
                const VerticalDivider(),
                ValueListenableBuilder(
                  valueListenable: Hive.box<Note>(notesBoxName).listenable(),
                  builder: (context, Box<Note> box, child) {
                    if (box.isEmpty) {
                      return Expanded(
                        child: _singleItem(
                          context,
                          ProfileInfoItem("یاداشت ها", 0),
                        ),
                      );
                    }

                    return Expanded(
                      child: _singleItem(
                        context,
                        ProfileInfoItem("یاداشت ها", box.values.length),
                      ),
                    );
                  },
                ),
                VerticalDivider(),
                ValueListenableBuilder(
                  valueListenable: Hive.box(coinsBoxName).listenable(),
                  builder: (context, Box box, child) {
                    return Expanded(
                      child: _singleItem(
                        context,
                        ProfileInfoItem("سکه ها", box.get('coins') ?? 0),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: labelStyle,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;

  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Colors.teal.shade500, Colors.cyan.shade600]),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Image(image: AssetImage('assets/avatar.png')),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
