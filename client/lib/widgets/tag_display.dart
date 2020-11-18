import 'package:flutter/material.dart';

import '../generated/model/tag.dart';

class TagDisplay extends StatelessWidget {
  TagDisplay({@required this.tag})
      : assert(tag != null);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: tag.color,
      label: Text(
        tag.title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .overline
            .copyWith(color: _estimateForegroundColor()),
      ),
    );
  }

  Color _estimateForegroundColor() =>
      ThemeData.estimateBrightnessForColor(tag.color) == Brightness.light
          ? Colors.black
          : Colors.white;
}
