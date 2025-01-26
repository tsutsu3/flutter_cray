import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cray/flutter_cray.dart';
import 'dart:ffi' as ffi;
import 'package:flutter_cray/flutter_cray_bindings_generated.dart';

Future<void> setupDefaultFiles() async {
  final directory = await getApplicationDocumentsDirectory();

  final sampleFilePath = '${directory.path}/sample.json';

  if (!File(sampleFilePath).existsSync()) {
    await copyAssetToFile('assets/sample.json', sampleFilePath);
  }
}

Future<void> copyAssetToFile(String assetPath, String destinationPath) async {
  // アセットを読み込む
  final byteData = await rootBundle.load(assetPath);

  // ファイルに書き込む
  final file = File(destinationPath);
  await file.writeAsBytes(byteData.buffer.asUint8List());
}

// class UserData extends ffi.Struct {
//   ffi.Pointer<cr_renderer> r;
//   int shouldSave;
// }

// c-ray/src/driver/main.c
bool cray({
  CrLogLevel? logLevel,
  String inputFile = 'sample.json',
}) {
  debugPrint('flutter c-ray v${getVersion()}, ${getGitHash()}');
  if (logLevel != null) {
    logLevelSet(logLevel);
  }

  final renderer = Renderer.create();

  if (inputFile.isNotEmpty) {
    final loadJsonResult = loadJson(renderer, inputFile);
    debugPrint(loadJsonResult
        ? 'Loaded scene from $inputFile'
        : 'Failed to load scene from $inputFile');
    if (loadJsonResult == false) {
      return false;
    }
  }

  // renderer.setCallbback(CrRendererCallbackEnum.onStart);
  // renderer.setCallbback(CrRendererCallbackEnum.onStop);
  // renderer.setCallbback(CrRendererCallbackEnum.onUpdate);

  int outNum = renderer.getNumPreference(CrRendererParamEnum.outputNum);
  int threads = renderer.getNumPreference(CrRendererParamEnum.threads);
  int widht = renderer.getNumPreference(CrRendererParamEnum.overrideWidth);
  int height = renderer.getNumPreference(CrRendererParamEnum.overrideHeight);
  int samples = renderer.getNumPreference(CrRendererParamEnum.samples);
  int bounces = renderer.getNumPreference(CrRendererParamEnum.bounces);

  debugPrint('Starting c-ray renderer for frame $outNum');
  debugPrint('Rendering at $widht x $height');
  debugPrint('Rendering $samples samples with $bounces bounces');
  debugPrint('Rendering with $threads threads');

  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // アプリ起動時にファイルをセットアップ
  await setupDefaultFiles();

  runApp(const MyApp());

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/sample.json';
  cray(inputFile: filePath);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? filePath; // ファイルパスを格納する変数
  final renderer = Renderer.create();

  @override
  void initState() {
    super.initState();
    _initFilePath(); // 非同期でファイルパスを取得
  }

  Future<void> _initFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      filePath = '${directory.path}/sample.json';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'C-Ray',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
