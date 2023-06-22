import 'package:flutter/material.dart';

OutlinedBorder _shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
);

BorderSide _border(Color color) => BorderSide(width: 2, color: color);

class FilledBtn extends StatelessWidget {
  const FilledBtn({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.child,
  });

  final void Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor.withOpacity(0.5);
          }
          return backgroundColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.5);
          }
          return foregroundColor;
        }),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(_shape),
      ),
      child: child,
    );
  }
}

class BorderBtn extends StatelessWidget {
  const BorderBtn({
    super.key,
    required this.onPressed,
    required this.foregroundColor,
    required this.borderColor,
    required this.child,
  });

  final void Function()? onPressed;
  final Color foregroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.5);
          }
          return foregroundColor;
        }),
        shape: MaterialStateProperty.all<OutlinedBorder>(_shape),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.disabled)) {
            return _border(foregroundColor.withOpacity(0.5));
          }
          return _border(foregroundColor);
        }),
      ),
      child: child,
    );
  }
}

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
    return FilledBtn(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      foregroundColor: Theme.of(context).colorScheme.background,
      onPressed: onPressed,
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
    return BorderBtn(
      onPressed: onPressed,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
      borderColor: Theme.of(context).colorScheme.onBackground,
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
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(_shape),
      ),
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
    return BorderBtn(
      onPressed: onPressed,
      foregroundColor: Theme.of(context).colorScheme.primary,
      borderColor: Theme.of(context).colorScheme.primaryContainer,
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
