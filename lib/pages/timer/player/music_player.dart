import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:taskizer/components/button/circle_btn.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/file.dart';
import 'package:taskizer/models/music.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool _isPlaying = false;
  AudioPlayer? _player;
  Music? _music;

  Widget _musicSelector() {
    return ElevatedButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title:
                      const Text('انتخاب موسیقی', textAlign: TextAlign.center),
                  content: Container(
                    height: 240,
                    child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box<Music>(musicsBoxName).listenable(),
                      builder: (context, Box<Music> box, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ...box.values.map((m) {
                              return ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _music = m;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(m.name));
                            })
                          ],
                        );
                      },
                    ),
                  ));
            },
          );
        },
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(_music!.name)),
            SizedBox(width: 6),
            Icon(Icons.headphones),
          ],
        ));
  }

  Widget _buildPlayerCtrl() {
    return CircleButton(
        color: Colors.white,
        bgColor: Colors.teal.shade300,
        icon: Icons.play_arrow,
        callback: () {});
  }

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
              content: Container(
                  height: 140,
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_musicSelector()],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleButton(
                              color: Colors.white,
                              bgColor: Colors.green.shade300,
                              icon: Icons.skip_next,
                              callback: () {}),
                          _buildPlayerCtrl(),
                          CircleButton(
                              color: Colors.white,
                              bgColor: Colors.green.shade300,
                              icon: Icons.skip_previous,
                              callback: () {}),
                        ],
                      ),
                    ],
                  )),
            );
          },
        );
      },
      icon: const Icon(Icons.headphones),
    );
  }
}
