import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_cray/enums.dart';
import 'package:flutter_cray/loader.dart';
import 'package:flutter_cray/renderer.dart';

// ============================================================================
// Library Info
// ============================================================================

/// Returns the version of the native c-ray library.
String getVersion() {
  return bindings.cr_get_version().cast<Utf8>().toDartString();
}

/// Returns the git hash of the native c-ray library.
String getGitHash() {
  return bindings.cr_get_git_hash().cast<Utf8>().toDartString();
}

// ============================================================================
// Logging
// ============================================================================

/// Set the log level of the native c-ray library.
void logLevelSet(CrLogLevel level) {
  bindings.cr_log_level_set(level.toInt());
}

/// Get the log level of the native c-ray library.
CrLogLevel logLevelGet() {
  return CrLogLevel.fromInt(bindings.cr_log_level_get());
}

// ============================================================================
// Misc
// ============================================================================

/// Send a shutdown signal to the workers.
void sendShutdownToWorkers(String nodeList) {
  final nodeListPtr = nodeList.toNativeUtf8();

  try {
    bindings.cr_send_shutdown_to_workers(nodeListPtr.cast<Char>());
  } finally {
    malloc.free(nodeListPtr);
  }
}

/// Load json scene from file.
bool loadJson(Renderer renderer, String filename) {
  final filenamePtr = filename.toNativeUtf8();

  try {
    return bindings.cr_load_json(renderer.pointer, filenamePtr.cast<Char>());
  } finally {
    malloc.free(filenamePtr);
  }
}
