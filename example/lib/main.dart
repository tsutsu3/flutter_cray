import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cray/flutter_cray.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// JSON文字列をファイルに保存
Future<String> saveJsonToFile(String jsonString, String fileName) async {
  // 保存先ディレクトリを取得
  final directory = await getApplicationDocumentsDirectory();

  // 保存先ファイルのパスを作成
  final filePath = '${directory.path}/$fileName';

  // ファイルを作成してJSON文字列を書き込む
  final file = File(filePath);
  await file.writeAsString(jsonString);

  // ファイルパスを返す
  return filePath;
}

Future<String> getFilePath(String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/$fileName';
}

final scene = '''{
  "version": 1.0,
  "renderer": {
    "threads": 0,
    "samples": 250,
    "bounces": 30,
    "tileWidth": 64,
    "tileHeight": 64,
    "tileOrder": "fromMiddle",
    "outputFilePath": "output/",
    "outputFileName": "rendered",
    "fileType": "png",
    "count": 0,
    "width": 800,
    "height": 800
  },
  "display": {"isFullscreen": false, "isBorderless": false, "windowScale": 1.0},
  "camera": {
    "FOV": 10.0,
    "focalDistance": 0.7,
    "fstops": 0,
    "transforms": [
      {"type": "translate", "x": 0, "y": 0.1, "z": -0.7},
      {"type": "rotateX", "degrees": 5},
      {"type": "rotateZ", "degrees": 0}
    ]
  },
  "scene": {
    "ambientColor": {
      "type": "background",
      "offset": 0,
      "down": {"r": 1.0, "g": 1.0, "b": 1.0},
      "up": {"r": 0.5, "g": 0.7, "b": 1.0}
    },
    "primitives": [
      {
        "type": "sphere",
        "instances": [
          {
            "transforms": [
              {"type": "rotateY", "degrees": 110},
              {"type": "translate", "x": 0, "y": 0.05, "z": 0}
            ]
          }
        ],
        "material": {
          "type": "plastic",
          "color": {"r": 1.0, "g": 0.87, "b": 0.0},
          "roughness": 0
        },
        "radius": 0.05
      }
    ],
    "meshes": []
  }
}''';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? filePath; // ファイルパスを保持
  @override
  void initState() {
    super.initState();

    saveJsonToFile(scene, 'scene.json').then((path) {
      setState(() {
        filePath = path; // ファイルパスを保存
      });
      print('File saved at: $path');
    }).catchError((e) {
      print('Error saving JSON: $e');
    });
  }

  final renderer = Renderer.create();

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
                  filePath != null
                      ? 'loadJson: ${loadJson(renderer, filePath!)}'
                      : 'Loading file...',
                ),
                Text(
                  renderer
                      .setStrPreference(
                          CrRendererParamEnum.outputPath, 'output/')
                      .toString(),
                ),
                Text(renderer.getStrPreference(CrRendererParamEnum.outputPath))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
