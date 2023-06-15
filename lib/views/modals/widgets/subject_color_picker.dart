import 'package:flutter/material.dart';
import 'package:sc_app/views/themes/color_scheme.dart';

class SubjectColorPicker extends StatelessWidget {
  const SubjectColorPicker({
    super.key,
    required this.pickedColorName,
    required this.onChanged,
  });

  final String pickedColorName;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final subjectColorNames = context.subjectColors.keys.toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (constraints.maxWidth ~/ 40),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: subjectColorNames.length,
          itemBuilder: (context, index) {
            return ColorRadioButton(
              colorName: subjectColorNames[index],
              selectedColorName: pickedColorName,
              onChanged: (value) => onChanged(value),
            );
          },
        );
      },
    );
  }
}

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({
    super.key,
    required this.colorName,
    required this.selectedColorName,
    required this.onChanged,
  });

  final String colorName;
  final String selectedColorName;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final color = context.subjectColors[colorName];
    bool isSelected = colorName == selectedColorName;

    return RawMaterialButton(
      onPressed: () => onChanged(colorName),
      splashColor: color,
      shape: RoundedRectangleBorder(
        side:
            isSelected ? BorderSide(color: color!, width: 2) : BorderSide.none,
        borderRadius: BorderRadius.circular(1000),
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: Container(
          height: 28,
          width: 28,
          color: color,
          alignment: Alignment.center,
          child: isSelected ? const Icon(Icons.done, size: 20) : null,
        ),
      ),
    );
  }
}
