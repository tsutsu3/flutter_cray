import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cray/flutter_cray.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
                  renderer
                      .setStrPreference(
                          RendererParam.cr_renderer_output_path, 'output/')
                      .toString(),
                ),
                Text(renderer
                    .getStrPreference(RendererParam.cr_renderer_output_path))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
