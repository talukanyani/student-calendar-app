import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/views/themes/color_scheme.dart';

enum SnackBarIcon {
  none,
  done,
  error,
  info,
}

SnackBar mySnackBar(BuildContext context, {
  required String text,
  required SnackBarIcon snackBarIcon,
  SnackBarAction? action,
}) {
  Widget getLeading() {
    Widget leading;

    switch (snackBarIcon) {
      case SnackBarIcon.done:
        leading = Icon(
          Iconsax.tick_circle,
          color: context.successContainerColor,
        );
        break;
      case SnackBarIcon.error:
        leading = Icon(
          Iconsax.close_circle,
          color: Theme
              .of(context)
              .colorScheme
              .errorContainer,
        );
        break;
      case SnackBarIcon.info:
        leading = Icon(
          Iconsax.info_circle,
          color: context.warningContainerColor,
        );
        break;
      default:
        leading = const SizedBox(width: 0);
    }

    return leading;
  }

  return SnackBar(
    content: Row(
      children: [
        getLeading(),
        SizedBox(width: snackBarIcon == SnackBarIcon.none ? 0 : 16),
        Expanded(child: Text(text)),
      ],
    ),
    action: action,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(8),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
