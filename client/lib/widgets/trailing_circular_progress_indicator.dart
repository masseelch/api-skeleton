import 'package:flutter/material.dart';

class TrailingCircularProgressIndicator extends StatelessWidget {
  const TrailingCircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: CircularProgressIndicator(strokeWidth: 1.5),
      height: 16.0,
      width: 16.0,
    );
  }
}
