import 'package:client/config.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App(
    config: const Config(
      env: Environment.dev,
      baseUrl: 'http://10.0.2.2:8000',
    ),
  ));
}
