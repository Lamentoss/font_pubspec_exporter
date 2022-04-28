import 'package:font_pubspec_exporter/models/font_model.dart';
import 'package:path/path.dart' as p;

class FontFamilyModel {
  final String assetFontsFolder;
  List<FontModel> fonts;

  FontFamilyModel(this.assetFontsFolder, {this.fonts = const []});

  toPubSpecYaml(assetsDir) {
    final sb = StringBuffer();
    sb.writeln('    - family: ${p.basename(assetFontsFolder).capitalize()}');
    sb.writeln('      fonts: ');
    for (var font in fonts) {
      sb.writeln(
          '         - asset: ${p.relative(font.fontFilePath, from: assetsDir)}');
      sb.writeln('           weight: ${font.fontWeigth}');
      if (font.isItalic) {
        sb.writeln('           style: italic');
      }
    }
    return sb.toString();
  }

  toExtension() {
    final fName = p.basename(assetFontsFolder).toLowerCase();
    return 'TextStyle get $fName => copyWith(fontFamily: FontFamily.$fName);';
  }
}

extension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
