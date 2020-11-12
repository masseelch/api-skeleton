import 'package:flutter/material.dart';

class CenteredCircularProgressIndicator extends StatelessWidget {
  const CenteredCircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(),
    );
  }
}
