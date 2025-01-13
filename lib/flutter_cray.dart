import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

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
final FlutterCrayBindings _bindings = FlutterCrayBindings(_dylib);

// ============================================================================
// Enums
// ============================================================================

typedef RendererParam = cr_renderer_param;
typedef TileState = cr_tile_state;
typedef RendererCallback = cr_renderer_callback;
typedef CameraParam = cr_camera_param;
typedef ObjectType = cr_object_type;
typedef LogLevel = cr_log_level;

// ============================================================================
// Functions
// ============================================================================

/// Returns the version of the native c-ray library.
///
/// This function is a wrapper around the native function `cr_get_version`.
///
/// The return value is a string containing the version of the native c-ray library.
String getVersion() {
  return _bindings.cr_get_version().cast<Utf8>().toDartString();
}

/// Returns the git hash of the native c-ray library.
///
/// This function is a wrapper around the native function `cr_get_git_hash`.
///
/// The return value is a string containing the git hash of the native c-ray library.
String getGitHash() {
  return _bindings.cr_get_git_hash().cast<Utf8>().toDartString();
}

/// Set the log level of the native c-ray library.
///
/// This function is a wrapper around the native function `cr_log_level_set`.
///
/// - `level`: The log level to set. Should be one of `LogLevel.*`
void setLogLevel(int level) {
  _bindings.cr_log_level_set(level);
}

/// Get the log level of the native c-ray library.
///
/// This function is a wrapper around the native function `cr_log_level_get`.
///
/// Returns the current log level of the native c-ray library.
int getLogLevel() {
  return _bindings.cr_log_level_get();
}

void sendShutdownToWorkers(String nodeList) {
  final Pointer<Utf8> nodeListPtr = nodeList.toNativeUtf8();

  try {
    _bindings.cr_send_shutdown_to_workers(nodeListPtr.cast<Char>());
  } finally {
    malloc.free(nodeListPtr);
  }
}

// ============================================================================
// Classes
// ============================================================================

/// A Dart wrapper for the native C-ray renderer.
///
/// This class provides an interface to control the renderer settings
/// and preferences using the native `c-ray` library.
class Renderer {
  /// The native pointer to the C-ray renderer.
  final Pointer<cr_renderer> _ptr;

  /// Private constructor to prevent direct instantiation.
  Renderer._(this._ptr);

  /// Returns the native pointer (for advanced use cases).
  Pointer<cr_renderer> get pointer => _ptr;

  /// Creates a new instance of the C-ray renderer.
  factory Renderer.create() {
    return Renderer._(_bindings.cr_new_renderer());
  }

  /// Releases the allocated memory for this renderer.
  void dispose() {
    _bindings.cr_destroy_renderer(_ptr);
  }

  // TODO
  /// Set a callback for the renderer
  // bool setCallback(
  //     int rendererCallback,
  //     Pointer<NativeFunction<RendererCallback>> callback,
  //     Pointer<Void> userData) {
  //   return _bindings.cr_renderer_set_callback(
  //       _ptr, rendererCallback, callback, userData);
  // }

  /// Set a numeric preference for the renderer
  ///
  /// The available parameters are defined in the `cr_renderer_param` class.
  ///
  /// - `rendererParam`: The parameter to set. Should be one of `cr_renderer_param.*`
  /// - `value`: The numeric value to assign to the parameter.
  ///
  /// Returns `true` if the preference was set successfully, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// renderer.setNumPreference(cr_renderer_param.cr_renderer_threads, 8);
  /// ```
  bool setNumPreference(int rendererParam, int value) {
    return _bindings.cr_renderer_set_num_pref(_ptr, rendererParam, value);
  }

  /// Set a string preference for the renderer
  /// ///
  /// The available parameters are defined in the `cr_renderer_param` class.
  ///
  /// - `rendererParam`: The parameter to set. Should be one of `cr_renderer_param.*`
  /// - `value`: The string value to assign to the parameter.
  ///
  /// Returns `true` if the preference was set successfully, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// renderer.setStrPreference(cr_renderer_param.cr_renderer_output_path, "output/");
  /// ```
  bool setStrPreference(int rendererParam, String value) {
    final Pointer<Utf8> valuePtr = value.toNativeUtf8();

    try {
      return _bindings.cr_renderer_set_str_pref(
          _ptr, rendererParam, valuePtr.cast<Char>());
    } finally {
      malloc.free(valuePtr);
    }
  }

  /// Stop the renderer
  ///
  /// Example:
  /// ```dart
  /// renderer.stop();
  /// ```
  void stop() {
    _bindings.cr_renderer_stop(_ptr);
  }

  void restartInteractive() {
    _bindings.cr_renderer_restart_interactive(_ptr);
  }

  void togglePause() {
    _bindings.cr_renderer_toggle_pause(_ptr);
  }

  String getStrPreference(int rendererParam) {
    final Pointer<Char> resultPtr =
        _bindings.cr_renderer_get_str_pref(_ptr, rendererParam);

    if (resultPtr == nullptr) {
      return ''; // Handle null pointer case gracefully
    }

    final String result = resultPtr.cast<Utf8>().toDartString();

    // Assuming the native function allocates memory, free it after conversion
    malloc.free(resultPtr);

    return result;
  }

  int getNumPreference(int rendererParam) {
    return _bindings.cr_renderer_get_num_pref(_ptr, rendererParam);
  }
}
