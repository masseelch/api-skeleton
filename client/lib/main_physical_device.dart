import 'package:client/config.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App(
    config: const Config(
      env: Environment.dev,
      baseUrl: 'http://192.168.10.140:8000',
    ),
  ));
}
