import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_cray/flutter_cray_bindings_generated.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cray = CRay.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
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
                  'version: ${cray.getVersion()}',
                  style: textStyle,
                ),
                Text(
                  'git hash: ${cray.getGitHash()}',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
