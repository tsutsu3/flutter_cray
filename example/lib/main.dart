import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cray/flutter_cray.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // アプリ起動時にファイルをセットアップ
  await setupDefaultFiles();

  runApp(const MyApp());
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
                  'version: ${getVersion()}',
                ),
                Text(
                  'git hash: ${getGitHash()}',
                ),
                Text(
                  'File Path: ${filePath ?? "Loading..."}', // ファイルパスを表示
                ),
                Text('loadJson: ${loadJson(renderer, filePath!)}'),
                Text(
                  renderer
                      .setStrPreference(
                          CrRendererParamEnum.outputPath, 'output/')
                      .toString(),
                ),
                Text(renderer.getStrPreference(CrRendererParamEnum.outputPath)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
