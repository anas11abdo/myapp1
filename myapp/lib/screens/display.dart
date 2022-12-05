// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class dis extends StatefulWidget {
  String base64;
  String name;
  dis({Key? key, required this.base64, required this.name}) : super(key: key);

  @override
  State<dis> createState() => _disState();
}

class _disState extends State<dis> {
  bool isFolderCreated = false;
  Directory? directory;

  checkDocumentFolder() async {
    try {
      if (!isFolderCreated) {
        directory = await getApplicationDocumentsDirectory();
        await directory!.exists().then((value) {
          if (value) directory!.create();
          isFolderCreated = true;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<File?> downloadFile() async {
    final base64str = widget.base64;
    Uint8List bytes = base64.decode(base64str);
    await checkDocumentFolder();
    String dir = directory!.path + "/" + widget.name + ".pdf";
    File file = File(dir);
    if (!file.existsSync()) file.create();
    await file.writeAsBytes(bytes);
    return file;
  }

  Future oppenFile(String fileName) async {
    final file = await downloadFile();
    OpenFile.open(file!.path);
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      oppenFile(widget.name);
      _deleteAppDir();
    });
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ]),
            ),
          ),
          shadowColor: Colors.blue,
          title: const Text(
            "عرض PDF",
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 105, 64, 133),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
              Text(
                "تم العرض بنجاح",
              ),
            ])));
  }
}
