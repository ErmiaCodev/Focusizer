import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/models/file.dart';
import '/constants/db.dart';
import '/models/note.dart';
import '/styles/global.dart';

class FileAddPage extends StatefulWidget {
  @override
  _FileAddPageState createState() => _FileAddPageState();
}

class _FileAddPageState extends State<FileAddPage> {
  String _name = "";
  String _type = "";
  File? _file;

  var labels = {
    'nan': 'نوع فایل',
    'pdf': 'مستند (PDF)',
    'image': 'تصویر',
  };

  void onFormSubmit() {
    Box<UserFile> filesBox = Hive.box<UserFile>(filesBoxName);
    // filesBox.add(UserFile(name: _name, path: ""));
  }

  Future<void> _pickDoc() async {
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
        title: Text("افزودن  فایل", style: titleStyle),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
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
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  underline: Container(),
                  hint: Text(labels[_type] ?? 'نوع فایل',
                      style: TextStyle(fontSize: 16)),
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
              SizedBox(height: 20),
              (_type != '') ? _buildPicker(context) : Text(""),
              SizedBox(height: 20),
              Flexible(
                  fit: FlexFit.loose,
                  child: FloatingActionButton.extended(
                    heroTag: 'submitNote',
                    onPressed: onFormSubmit,
                    label: Text("ذخیره", style: labelStyle),
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
