import 'dart:ffi';
// ignore: depend_on_referenced_packages
import 'package:ffi/ffi.dart';
import 'package:flutter_cray/flutter_cray.dart';

/// Singleton class for CRay bindings
class CRay {
  static final CRay _instance = CRay._internal(loadLibrary());

  final DynamicLibrary _lib;

  // Function pointers
  late final Pointer<Utf8> Function() _crGetVersion;
  late final Pointer<Utf8> Function() _crGetGitHash;

  late final Pointer<Void> Function() _crNewRenderer;
  late final void Function(Pointer<Void>) _crDestroyRenderer;
  late final void Function(Pointer<Void>) _crRendererRender;
  late final Pointer<Void> Function(Pointer<Void>) _crRendererGetResult;

  // Private constructor for singleton pattern
  CRay._internal(this._lib) {
    _crGetVersion =
        _lib.lookupFunction<Pointer<Utf8> Function(), Pointer<Utf8> Function()>(
            'cr_get_version');
    _crGetGitHash =
        _lib.lookupFunction<Pointer<Utf8> Function(), Pointer<Utf8> Function()>(
            'cr_get_git_hash');

    _crNewRenderer =
        _lib.lookupFunction<Pointer<Void> Function(), Pointer<Void> Function()>(
            'cr_new_renderer');
    _crDestroyRenderer = _lib.lookupFunction<Void Function(Pointer<Void>),
        void Function(Pointer<Void>)>('cr_destroy_renderer');
    _crRendererRender = _lib.lookupFunction<Void Function(Pointer<Void>),
        void Function(Pointer<Void>)>('cr_renderer_render');
    _crRendererGetResult = _lib.lookupFunction<
        Pointer<Void> Function(Pointer<Void>),
        Pointer<Void> Function(Pointer<Void>)>('cr_renderer_get_result');
  }

  /// Get the singleton instance
  static CRay get instance => _instance;

  /// Get version as a Dart string
  String getVersion() => _crGetVersion().toDartString();

  /// Get Git hash as a Dart string
  String getGitHash() => _crGetGitHash().toDartString();

  /// Create a new renderer
  Pointer<Void> newRenderer() => _crNewRenderer();

  /// Destroy an existing renderer
  void destroyRenderer(Pointer<Void> renderer) => _crDestroyRenderer(renderer);

  /// Start rendering a scene
  void render(Pointer<Void> renderer) => _crRendererRender(renderer);

  /// Get rendered result
  Pointer<Void> getResult(Pointer<Void> renderer) =>
      _crRendererGetResult(renderer);
}

// /// **Dart Enum equivalent to C enum cr_log_level**
// enum CrLogLevel {
//   error(0),
//   info(1),
//   warning(2),
//   debug(3),
//   plain(4),
//   spam(5);

//   final int value;
//   const CrLogLevel(this.value);

//   static CrLogLevel fromValue(int value) {
//     return CrLogLevel.values
//         .firstWhere((e) => e.value == value, orElse: () => CrLogLevel.plain);
//   }
// }

// /// **Bind `void log_level_set(enum cr_log_level);`**
// typedef CrLogLevelSetC = Void Function(Int32 level);
// typedef CrLogLevelSetDart = void Function(int level);

// final CrLogLevelSetDart crLogLevelSet = ffiLib
//     .lookup<NativeFunction<CrLogLevelSetC>>('cr_log_level_set')
//     .asFunction<CrLogLevelSetDart>();

// /// **Bind `enum cr_log_level log_level_get(void);`**
// typedef CrLogLevelGetC = Int32 Function();
// typedef CrLogLevelGetDart = int Function();

// final CrLogLevelGetDart crLogLevelGet = ffiLib
//     .lookup<NativeFunction<CrLogLevelGetC>>('cr_log_level_get')
//     .asFunction<CrLogLevelGetDart>();

// /// **Dart Wrapper Class**
// void setCrLogLevel(CrLogLevel level) {
//   crLogLevelSet(level.value);
// }

// /// Get the current log level
// CrLogLevel getCrLogLevel() {
//   return CrLogLevel.fromValue(crLogLevelGet());
// }
