import 'dart:io';

import 'package:path_provider/path_provider.dart';

class InforProvider {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/info.txt');
  }

  static Future<File> writeInfo(String data) async {
    final file = await _localFile;

    return file.writeAsString('$data');
  }

  static Future<String> readInfo() async {
    try {
      final file = await _localFile;

      var contents = await file.readAsString();

      return contents;
    } catch (e) {
      return '';
    }
  }
}
