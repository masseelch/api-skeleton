import 'package:flutter/material.dart';

import '../generated/model/tag.dart';

class TagDisplay extends StatelessWidget {
  TagDisplay({
    @required this.tag,
    this.onTap,
  }) : assert(tag != null);

  final Tag tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Widget chip = Chip(
      backgroundColor: tag.color,
      label: Text(
        tag.title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .overline
            .copyWith(color: _estimateForegroundColor()),
      ),
    );

    if (onTap != null) {
      chip = InkWell(
        onTap: onTap,
        child: chip,
      );
    }

    return chip;
  }

  Color _estimateForegroundColor() =>
      ThemeData.estimateBrightnessForColor(tag.color) == Brightness.light
          ? Colors.black
          : Colors.white;
}
