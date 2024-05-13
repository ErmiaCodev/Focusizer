import 'package:flutter/material.dart';
import 'package:taskizer/models/music.dart';
import 'package:taskizer/styles/global.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({required this.index, required this.music, super.key});

  final Music music;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.teal.shade200)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(music.name, style: titleStyle),
                  ),
                  FloatingActionButton.small(
                    heroTag: 'music_trash_$index',
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      music.delete();
                    },
                    child: const Icon(Icons.recycling),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
