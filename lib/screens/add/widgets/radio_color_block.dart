import 'package:flutter/material.dart';
import 'package:sc_app/utils/table_colors.dart';

class RadioColorBlock extends StatelessWidget {
  const RadioColorBlock({
    super.key,
    required this.color,
    required this.selectedColor,
    required this.onChanged,
  });

  final String color;
  final String selectedColor;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    bool isSelected = color == selectedColor;

    return RawMaterialButton(
      onPressed: () => onChanged(color),
      splashColor: tableColors[color],
      shape: RoundedRectangleBorder(
        side: isSelected
            ? BorderSide(
                color: tableColors[color]!,
                width: 2,
              )
            : BorderSide.none,
        borderRadius: BorderRadius.circular(1000),
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: Container(
          height: 28,
          width: 28,
          color: tableColors[color],
          alignment: Alignment.center,
          child: isSelected ? const Icon(Icons.done, size: 20) : null,
        ),
      ),
    );
  }
}
