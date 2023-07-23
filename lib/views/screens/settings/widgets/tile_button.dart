import 'package:flutter/material.dart';
import 'package:sc_app/views/widgets/rect_container.dart';

class TileButton extends StatelessWidget {
  const TileButton({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.onTap,
  });

  final Widget title;
  final Widget? leading;
  final Widget? subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RectContainer(
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          title: title,
          subtitle: subtitle,
          leading: leading,
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
