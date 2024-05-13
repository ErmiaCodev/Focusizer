import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/music.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              title: Text("موسیقی", textAlign: TextAlign.center),
              content: Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  children: [
                    // FloatingActionButton(onPressed: () {}, icon: Icon(Icons.play_arrow))
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.headphones),
    );
  }
}
