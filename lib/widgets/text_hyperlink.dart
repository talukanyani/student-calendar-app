import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextHyperlink extends StatelessWidget {
  const TextHyperlink({
    super.key,
    required this.text,
    required this.textStyle,
    required this.url,
  });

  final String text;
  final TextStyle? textStyle;
  final String url;

  Future<void> _launch() async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _launch(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: textStyle),
    );
  }
}
