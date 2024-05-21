import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/components/guard/guard.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/music.dart';
import 'package:taskizer/pages/musics/widgets/music_item.dart';
import 'package:taskizer/styles/global.dart';

class MusicsPage extends StatelessWidget {
  const MusicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Guard(
        child: Scaffold(
      appBar: Navbar("موسیقی ها"),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Music>(musicsBoxName).listenable(),
          builder: (context, Box<Music> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text(
                  "!موسیقی وجود ندارد",
                  style: titleStyle,
                  textDirection: TextDirection.ltr,
                ),
              );
            }

            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Music music = box.values.elementAt(index);
                return MusicItem(music: music, index: index);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'musicList',
        onPressed: () {
          Navigator.of(context).pushNamed("/musics/add");
        },
        backgroundColor: Colors.teal.shade300,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    ));
  }
}
