import 'package:path/path.dart' as p;

class FontModel {
  final String fontFilePath;

  FontModel(this.fontFilePath);
  String get fileName => p.basenameWithoutExtension(fontFilePath);
  bool get isItalic => fileName.toLowerCase().contains('italic');
  int get fontWeigth {
    final _fname = fileName.toLowerCase();
    if (_fname.contains('ultra') && _fname.contains('black')) {
      return 950;
    }
    if (_fname.contains('black') || _fname.contains('heavy')) {
      return 900;
    }
    if (_fname.contains('bold') &&
        (_fname.contains('extra') || _fname.contains('ultra'))) {
      return 800;
    }
    if (_fname.contains('bold') &&
        !((_fname.contains('extra') || _fname.contains('ultra')) ||
            _fname.contains('semi') ||
            _fname.contains('demi'))) {
      return 700;
    }
    if (_fname.contains('bold') &&
        (_fname.contains('semi') || _fname.contains('demi'))) {
      return 600;
    }

    if (_fname.contains('medium')) {
      return 500;
    }

    if (_fname.contains('normal') || _fname.contains('regular')) {
      return 400;
    }

    if (_fname.contains('light') &&
        !((_fname.contains('extra') || _fname.contains('ultra')))) {
      return 300;
    }

    if (_fname.contains('light') &&
        (_fname.contains('extra') || _fname.contains('ultra'))) {
      return 200;
    }

    if (_fname.contains('thin') || _fname.contains('hairline')) {
      return 100;
    }

    if (_fname.contains('italic')) {
      return 400;
    }

    return -1;
  }
}
