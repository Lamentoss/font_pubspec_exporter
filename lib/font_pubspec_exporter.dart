import 'dart:async';
import 'dart:io';

import 'package:font_pubspec_exporter/models/font_family_model.dart';
import 'package:font_pubspec_exporter/models/font_model.dart';
import 'package:font_pubspec_exporter/utils/file_system_utls.dart';
import 'package:path/path.dart';

class FontPubSpecExporter {
  static Future<List<FontFamilyModel>> _exportFontsByDir(
      String fontsDir) async {
    final Directory fontsDirObj = Directory(fontsDir);

    final fontsDirs = await FileSystemUtils.getFoldersOfFolder(fontsDirObj);

    final List<FontFamilyModel> fontFamilies = [];

    for (var _fontDir in fontsDirs) {
      List<FontModel> fonts = [];
      final fontsFiles = await FileSystemUtils.getListOfFiles(
          Directory(_fontDir.path),
          extensions: ['.otf', '.ttf']);

      fonts.addAll(fontsFiles.map((e) => FontModel(e.path)));
      fonts.sort(((a, b) => a.fontWeigth.compareTo(b.fontWeigth)));
      fontFamilies.add(FontFamilyModel(_fontDir.path, fonts: fonts));
    }
    return fontFamilies;
  }

  static void pubSpecExport(String flutterProjectDir) async {
    final fontsDir = join(flutterProjectDir, 'assets/fonts');
    final fonts = await _exportFontsByDir(fontsDir);
    for (var font in fonts) {
      print(font.toPubSpecYaml(flutterProjectDir));
    }

    for (var font in fonts) {
      print(font.toExtension());
    }
    print(_fontWeightsAndSizeFn);
  }

  static const _fontWeightsAndSizeFn = '''
      //TextStyle get extraBlack => copyWith(fontWeight: FontWeight.w950);
      //TextStyle get ultraBlack => copyWith(fontWeight: FontWeight.w950);
      TextStyle get black => copyWith(fontWeight: FontWeight.w900);
      TextStyle get heavy => copyWith(fontWeight: FontWeight.w900);
      TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
      TextStyle get ultraBold => copyWith(fontWeight: FontWeight.w800);
      TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
      TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
      TextStyle get demiBold => copyWith(fontWeight: FontWeight.w600);
      TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
      TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
      TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
      TextStyle get light => copyWith(fontWeight: FontWeight.w300);
      TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
      TextStyle get ultraLight => copyWith(fontWeight: FontWeight.w200);
      TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
      TextStyle get hairLine => copyWith(fontWeight: FontWeight.w100);
      TextStyle size(double size) => copyWith(fontSize: size);
      ''';
}
