import 'package:font_pubspec_exporter/font_pubspec_exporter.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Define project directory!');
    return;
  }
  final flutterProjectDir = arguments[0];
  FontPubSpecExporter.pubSpecExport(flutterProjectDir);

  // print('Hello world: ${font_pubspec_exporter.calculate()}!');
}
