import 'dart:ffi';
import 'package:flutter_cray/flutter_cray.dart';

/// **Dart Enum equivalent to C enum cr_log_level**
enum CrLogLevel {
  error(0),
  info(1),
  warning(2),
  debug(3),
  plain(4),
  spam(5);

  final int value;
  const CrLogLevel(this.value);

  static CrLogLevel fromValue(int value) {
    return CrLogLevel.values
        .firstWhere((e) => e.value == value, orElse: () => CrLogLevel.plain);
  }
}

/// **Bind `void log_level_set(enum cr_log_level);`**
typedef CrLogLevelSetC = Void Function(Int32 level);
typedef CrLogLevelSetDart = void Function(int level);

final CrLogLevelSetDart crLogLevelSet = ffiLib
    .lookup<NativeFunction<CrLogLevelSetC>>('cr_log_level_set')
    .asFunction<CrLogLevelSetDart>();

/// **Bind `enum cr_log_level log_level_get(void);`**
typedef CrLogLevelGetC = Int32 Function();
typedef CrLogLevelGetDart = int Function();

final CrLogLevelGetDart crLogLevelGet = ffiLib
    .lookup<NativeFunction<CrLogLevelGetC>>('cr_log_level_get')
    .asFunction<CrLogLevelGetDart>();

/// **Dart Wrapper Class**
void setCrLogLevel(CrLogLevel level) {
  crLogLevelSet(level.value);
}

/// Get the current log level
CrLogLevel getCrLogLevel() {
  return CrLogLevel.fromValue(crLogLevelGet());
}
