import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/models/file.dart';
import '/constants/db.dart';
import '/styles/global.dart';

class FileAddPage extends StatefulWidget {
  @override
  _FileAddPageState createState() => _FileAddPageState();
}

class _FileAddPageState extends State<FileAddPage> {
  String _name = "";
  String _type = "";
  String _fileType = "";
  File? _file;

  var labels = {
    'pdf': 'مستند (PDF)',
    'image': 'تصویر',
  };

  Future<void> onFormSubmit() async {
    if (_type == "" || _fileType == "" || _name == "" || _file == null) {
      return;
    }

    Box<UserFile> filesBox = Hive.box<UserFile>(filesBoxName);

    if (_file != null) {
      final fileName = _file!.path.split('/').last;
      final String appPath = (await getApplicationDocumentsDirectory()).path;
      final File newFile = await _file!.copy('$appPath/$fileName');
      filesBox.add(UserFile(name: _name, type: _fileType, path: newFile.path));
      Navigator.pop(context);
    }
  }

  Future<void> _pickDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf']);

    if (result == null) {
      return;
    }

    File file = result.paths.map((path) => File(path!)).toList().first;
    setState(() {
      _file = file;
      _fileType = 'pdf';
    });
  }

  Future<void> _pickImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result == null) {
      return;
    }

    File file = result.paths.map((path) => File(path!)).toList().first;
    setState(() {
      _file = file;
      _fileType = 'image';
    });
  }

  Future<void> _filePicker() async {
    if (_type == 'pdf') {
      await _pickDoc();
    } else if (_type == 'image') {
      await _pickImg();
    }
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
        title: const Text("افزودن  فایل", style: titleStyle),
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButton<String>(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  underline: Container(),
                  hint: Text(labels[_type] ?? 'نوع فایل',
                      style: const TextStyle(fontSize: 16)),
                  items: const [
                    DropdownMenuItem<String>(
                        value: "image", child: Text("تصویر")),
                    DropdownMenuItem<String>(
                        value: "pdf", child: Text("مستند (PDF)")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _type = value ?? "";
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              (_type != '') ? _buildPicker(context) : const Text(""),
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
