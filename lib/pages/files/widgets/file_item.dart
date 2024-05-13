import 'dart:io';

import 'package:flutter/material.dart';
import '/pages/files/file_detail.dart';
import '/models/file.dart';
import '/styles/global.dart';

class FileItem extends StatelessWidget {
  FileItem({required this.file, required this.index, super.key});

  final UserFile file;
  final int index;

  Future<void> _deleteFile(UserFile file) async {
    file.delete();
    File file_instance = File(file.path);
    await file_instance.delete();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => FileDetailPage(file: file)));
      },
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(file.name, style: titleStyle),
                ),
                FloatingActionButton.small(
                  heroTag: 'task_trash_${index}',
                  backgroundColor: Colors.red.shade300,
                  foregroundColor: Colors.white,
                  onPressed: () => _deleteFile(file),
                  child: const Icon(Icons.recycling),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
