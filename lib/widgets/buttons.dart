import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';

OutlinedBorder shape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
);

class ForegroundFilledBtn extends StatelessWidget {
  const ForegroundFilledBtn({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CustomColorScheme.foreground5,
        foregroundColor: Theme.of(context).backgroundColor,
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

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        shape: shape,
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.onBackground,
        ),
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

  final void Function() onPressed;
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

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: shape,
        side: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
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

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: shape,
        backgroundColor: CustomColorScheme.background5,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      child: child,
    );
  }
}
