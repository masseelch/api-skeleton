import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({@required this.logo}) : assert(logo != null);

  final Widget logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: logo,
        ),
      ),
    );
  }
}
