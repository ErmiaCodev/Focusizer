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
  AudioPlayer _player = AudioPlayer();
  Music? _music;

  Widget _musicSelector(updater) {
    return ElevatedButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('انتخاب موسیقی', textAlign: TextAlign.center),
              content: Container(
                height: 240,
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Music>(musicsBoxName).listenable(),
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
                              updater(m.name);
                              Navigator.pop(context);
                            },
                            child: Text(m.name),
                          );
                        })
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(_music?.name ?? 'انتخاب')),
          const SizedBox(width: 6),
          const Icon(Icons.headphones),
        ],
      ),
    );
  }

  Widget _buildPlayerCtrl(callback, isPlaying) {
    return CircleButton(
      color: Colors.white,
      bgColor: Colors.teal.shade300,
      icon: isPlaying ? Icons.pause : Icons.play_arrow,
      callback: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final snackBar = SnackBar(
            content: Text("بزودی!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            backgroundColor: Colors.lightBlue.shade400);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return;
        await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setStateM) {
                String musicName = "";
                bool isPlaying = false;

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
                            children: [
                              _musicSelector((value) {
                                setStateM(() {
                                  musicName = value;
                                });
                              })
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleButton(
                                color: Colors.white,
                                bgColor: Colors.green.shade300,
                                icon: Icons.skip_next,
                                callback: () {},
                              ),
                              _buildPlayerCtrl(() {
                                if (_music != null) {
                                  setStateM(() {
                                    isPlaying = true;
                                  });
                                  setState(() {
                                    _isPlaying = true;
                                  });
                                  _player.setUrl(_music!.path);
                                  _player.play();
                                }
                              }, isPlaying),
                              CircleButton(
                                color: Colors.white,
                                bgColor: Colors.green.shade300,
                                icon: Icons.skip_previous,
                                callback: () {},
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              },
            );
          },
        );
      },
      icon: const Icon(Icons.headphones),
    );
  }
}
