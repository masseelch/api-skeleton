import 'package:client/config.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App(
    config: const Config(
      env: Environment.dev,
      baseUrl: 'http://192.168.0.120:8000', // Kiel
      // baseUrl: 'http://192.168.178.34:8000', // Wrist
    ),
  ));
}
