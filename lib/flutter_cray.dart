import 'dart:ffi';
import 'dart:io';

DynamicLibrary loadLibrary() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libc-ray.so');
  } else if (Platform.isLinux) {
    return DynamicLibrary.open('libc-ray.so');
  } else if (Platform.isWindows) {
    return DynamicLibrary.open('libc-ray.dll');
  }
  throw UnsupportedError('Unsupported platform');
}

final DynamicLibrary ffiLib = loadLibrary();
