import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:photo_view/photo_view.dart';
import '/components/appbar/navbar.dart';
import '/components/guard/guard.dart';
import '/models/file.dart';

class FileDetailPage extends StatefulWidget {
  const FileDetailPage({required this.file, super.key});

  final UserFile file;

  @override
  _FileDetailState createState() => _FileDetailState();
}

class _FileDetailState extends State<FileDetailPage> {
  File? _file;

  @override
  void initState() {
    File file = File(widget.file.path);
    setState(() {
      _file = file;
    });

    super.initState();
  }

  Widget _filePreview(BuildContext context) {
    if (widget.file.type == 'image') {
      return PhotoView(imageProvider: FileImage(_file!));
    }

    if (widget.file.type == 'pdf') {
      return PDFView(
        filePath: widget.file.path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onRender: (pages) {},
        onError: (error) {},
        onPageError: (page, error) {},
        onViewCreated: (PDFViewController pdfViewController) {},
      );
    }

    return const Text("");
  }

  @override
  Widget build(BuildContext context) {
    return Guard(
      child: Scaffold(
        appBar: Navbar(widget.file.name),
        body: Container(
          child: (_file != null)
              ? _filePreview(context)
              : const Text(""),
        ),
      ),
    );
  }
}
