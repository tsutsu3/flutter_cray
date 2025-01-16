import 'package:flutter_cray/flutter_cray.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Misc functions', () {
    test('getVersion', () {
      expect(getVersion(), isNotEmpty);
    });

    test('getGitHash', () {
      expect(getGitHash(), isNotEmpty);
    });

    test('setLogLevel', () {
      setLogLevel(1);
    });
  });
}
