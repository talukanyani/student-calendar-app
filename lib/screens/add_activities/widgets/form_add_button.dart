import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FormAddButton extends StatelessWidget {
  const FormAddButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: const Offset(0.2, 0.4),
                color: Theme.of(context).colorScheme.shadow,
              ),
            ],
          ),
          child: IconButton(
            onPressed: onPressed,
            tooltip: 'Add activity form',
            icon: const Icon(Iconsax.additem),
          ),
        ),
      ],
    );
  }
}
