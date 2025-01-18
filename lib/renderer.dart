import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_cray/enums.dart';
import 'package:flutter_cray/flutter_cray_bindings_generated.dart';
import 'package:flutter_cray/loader.dart';

/// A Dart wrapper for the native C-ray renderer.
///
/// This class provides an interface to control the renderer settings
/// and preferences using the native `c-ray` library.
class Renderer {
  /// Private constructor to prevent direct instantiation.
  Renderer._(this._ptr);

  /// The native pointer to the C-ray renderer.
  final Pointer<cr_renderer> _ptr;

  /// Returns the native pointer (for advanced use cases).
  Pointer<cr_renderer> get pointer => _ptr;

  /// Creates a new instance of the C-ray renderer.
  factory Renderer.create() {
    return Renderer._(bindings.cr_new_renderer());
  }

  /// Releases the allocated memory for this renderer.
  void dispose() {
    bindings.cr_destroy_renderer(_ptr);
  }

  // TODO
  /// Set a callback for the renderer
  // bool setCallback(
  //     int rendererCallback,
  //     Pointer<NativeFunction<RendererCallback>> callback,
  //     Pointer<Void> userData) {
  //   return bindings.cr_renderer_set_callback(
  //       _ptr, rendererCallback, callback, userData);
  // }

  /// Set a numeric preference for the renderer
  bool setNumPreference(CrRendererParamEnum rendererParam, int value) {
    return bindings.cr_renderer_set_num_pref(
      _ptr,
      rendererParam.toInt(),
      value,
    );
  }

  /// Set a string preference for the renderer
  bool setStrPreference(CrRendererParamEnum rendererParam, String value) {
    final valuePtr = value.toNativeUtf8();

    try {
      return bindings.cr_renderer_set_str_pref(
          _ptr, rendererParam.toInt(), valuePtr.cast<Char>());
    } finally {
      malloc.free(valuePtr);
    }
  }

  /// Stop the renderer
  void stop() {
    bindings.cr_renderer_stop(_ptr);
  }

  /// Restart the renderer in interactive mode
  void restartInteractive() {
    bindings.cr_renderer_restart_interactive(_ptr);
  }

  /// Toggle pause/resume for the renderer
  void togglePause() {
    bindings.cr_renderer_toggle_pause(_ptr);
  }

  /// Get a string preference for the renderer
  String getStrPreference(CrRendererParamEnum rendererParam) {
    final resultPtr =
        bindings.cr_renderer_get_str_pref(_ptr, rendererParam.toInt());

    if (resultPtr == nullptr) {
      return ''; // Handle null pointer case gracefully
    }

    final String result = resultPtr.cast<Utf8>().toDartString();

    // Assuming the native function allocates memory, free it after conversion
    malloc.free(resultPtr);

    return result;
  }

  /// Get a numeric preference for the renderer
  int getNumPreference(CrRendererParamEnum rendererParam) {
    return bindings.cr_renderer_get_num_pref(_ptr, rendererParam.toInt());
  }
}
