import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';

class FileSystemUtils {
  static Future<List<FileSystemEntity>> getListOfFiles(Directory folder,
      {List<String> extensions = const []}) {
    var folders = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = folder.list(recursive: false);
    lister.listen(
      (file) async {
        if (extensions.isNotEmpty &&
            !extensions.contains(extension(file.path))) {
          return;
        }
        FileSystemEntityType type = await FileSystemEntity.type(file.path);
        if (type == FileSystemEntityType.file) {
          folders.add(file);
        }
      },
      onDone: () => completer.complete(folders),
    );
    return completer.future;
  }

  static Future<List<FileSystemEntity>> getFoldersOfFolder(Directory folder) {
    var folders = <FileSystemEntity>[];
    var completer = Completer<List<FileSystemEntity>>();
    var lister = folder.list(recursive: false);
    lister.listen(
      (file) async {
        FileSystemEntityType type = await FileSystemEntity.type(file.path);
        if (type == FileSystemEntityType.directory) {
          folders.add(file);
        }
      },
      onDone: () => completer.complete(folders),
    );
    return completer.future;
  }
}
