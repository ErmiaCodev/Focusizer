import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/models/file.dart';
import 'package:taskizer/models/music.dart';
import '/constants/db.dart';
import '/models/note.dart';
import '/styles/global.dart';

class MusicAddPage extends StatefulWidget {
  @override
  _MusicAddPageState createState() => _MusicAddPageState();
}

class _MusicAddPageState extends State<MusicAddPage> {
  String _name = "";
  File? _file;


  Future<void> onFormSubmit() async {
    if (_name == "" || _file == null) {
      return;
    }

    Box<Music> musicsBox = Hive.box<Music>(musicsBoxName);

    if (_file != null) {
      final fileName = _file!.path.split('/').last;
      final String appPath = (await getApplicationDocumentsDirectory()).path;
      final File newFile = await _file!.copy('$appPath/$fileName');
      musicsBox.add(Music(name: _name, path: newFile.path));
      Navigator.pop(context);
    }
  }


  Future<void> _pickMusic() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'ogg', 'wav']
    );

    if (result == null) {
      return;
    }

    File file = result.paths.map((path) => File(path!)).toList().first;
    setState(() {
      _file = file;
    });
  }

  Future<void> _filePicker() async {
    await _pickMusic();
  }

  Widget _buildPicker(BuildContext context) {
    String? fname = _file?.path.split('/').last;
    String? name = (fname?.substring(0, 6) ?? '') +
        (fname?.substring(fname.length - 6, fname.length) ?? '');
    return ElevatedButton(
      child: Text(
        (_file == null) ? 'انتخاب فایل' : name ?? '',
      ),
      onPressed: () => _filePicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("افزودن  فایل", style: titleStyle),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    label: Text("نام")),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildPicker(context),
              const SizedBox(height: 20),
              Flexible(
                  fit: FlexFit.loose,
                  child: FloatingActionButton.extended(
                    heroTag: 'submitNote',
                    onPressed: () => onFormSubmit(),
                    label: const Text("ذخیره", style: labelStyle),
                    backgroundColor: Colors.teal.shade300,
                    foregroundColor: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
