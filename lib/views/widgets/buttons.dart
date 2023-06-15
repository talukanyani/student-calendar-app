import 'package:flutter/material.dart';

OutlinedBorder shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
);

BorderSide border(Color color) => BorderSide(width: 2, color: color);

class ForegroundFilledBtn extends StatelessWidget {
  const ForegroundFilledBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        foregroundColor: Theme.of(context).colorScheme.background,
        shape: shape,
      ),
      child: child,
    );
  }
}

class ForegroundBorderBtn extends StatelessWidget {
  const ForegroundBorderBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = Theme.of(context).colorScheme.onBackground;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.5);
          }
          return foregroundColor;
        }),
        shape: MaterialStateProperty.all<OutlinedBorder>(shape),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.disabled)) {
            return border(foregroundColor.withOpacity(0.5));
          }
          return border(foregroundColor);
        }),
      ),
      child: child,
    );
  }
}

class PrimaryFilledBtn extends StatelessWidget {
  const PrimaryFilledBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(elevation: 0, shape: shape),
      child: child,
    );
  }
}

class PrimaryBorderBtn extends StatelessWidget {
  const PrimaryBorderBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.primaryContainer;

    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(shape),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.disabled)) {
            return border(borderColor.withOpacity(0.5));
          }
          return border(borderColor);
        }),
      ),
      child: child,
    );
  }
}

class GreyFilledBtn extends StatelessWidget {
  const GreyFilledBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: shape,
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      child: child,
    );
  }
}

class InlineBtn extends StatelessWidget {
  const InlineBtn({
    super.key,
    required this.onPressed,
    required this.label,
    this.textStyle,
  });

  final void Function()? onPressed;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        minimumSize: const Size(0, 0),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: textStyle),
    );
  }
}
