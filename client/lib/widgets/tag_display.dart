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
        deleteIconColor: foregroundColor,
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

  Color _estimateForegroundColor() {
    final double relativeLuminance = tag.color.computeLuminance();

    // See <https://www.w3.org/TR/WCAG20/#contrast-ratiodef>
    // The spec says to use kThreshold=0.0525, but Material Design appears to bias
    // more towards using light text than WCAG20 recommends. Material Design spec
    // doesn't say what value to use, but 0.15 seemed close to what the Material
    // Design spec shows for its color palette on
    // <https://material.io/go/design-theming#color-color-palette>.
    //
    // However, for us this still seems to tend towards dark colors too early.
    const double kThreshold = 0.25;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
      return Colors.black;
    return Colors.white;
  }
}
