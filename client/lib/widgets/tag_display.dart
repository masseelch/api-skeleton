import 'package:flutter/material.dart';

import '../generated/model/tag.dart';

enum ChipStyle { basic, selectable }

class TagDisplay extends StatelessWidget {
  TagDisplay({
    @required this.tag,
    this.chipStyle = ChipStyle.basic,
    this.selected = true,
    this.onSelected,
    this.onTap,
    this.onDeleted,
  })  : assert(tag != null),
        assert(chipStyle != null),
        assert(chipStyle == ChipStyle.basic ||
            (selected != null && onSelected != null));

  final Tag tag;
  final ChipStyle chipStyle;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final VoidCallback onTap;
  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor = _estimateForegroundColor();

    if (chipStyle == ChipStyle.basic) {
      Widget chip = Chip(
        backgroundColor: tag.color,
        label: Text(
          tag.title,
          style: theme.textTheme.overline.copyWith(
            color: selected ? foregroundColor : theme.colorScheme.onSurface,
          ),
        ),
        onDeleted: onDeleted,
      );

      if (onTap != null) {
        chip = InkWell(
          onTap: onTap,
          child: chip,
        );
      }

      return chip;
    }

    return FilterChip(
      selected: selected,
      onSelected: onSelected ?? (_) {},
      backgroundColor: theme.canvasColor,
      selectedColor: tag.color,
      checkmarkColor: foregroundColor,
      side: selected ? null : BorderSide(color: tag.color),
      label: Text(
        tag.title.toUpperCase(),
        style: theme.textTheme.overline.copyWith(
          color: selected ? foregroundColor : theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Color _estimateForegroundColor() =>
      ThemeData.estimateBrightnessForColor(tag.color) == Brightness.light
          ? Colors.black
          : Colors.white;
}
