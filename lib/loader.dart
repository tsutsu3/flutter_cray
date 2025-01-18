import 'dart:ffi';
import 'dart:io';
import 'package:flutter_cray/flutter_cray_bindings_generated.dart';

const String _libName = 'c-ray';

/// The dynamic library in which the symbols for [FfigenAppBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final FlutterCrayBindings bindings = FlutterCrayBindings(_dylib);
