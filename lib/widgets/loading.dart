import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 32),
            Text(
              text ?? 'Loading...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
