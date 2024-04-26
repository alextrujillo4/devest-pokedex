import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;

  const ErrorWidget({
    super.key,
    required this.title,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 48),
            const Icon(
              Icons.info_rounded,
              size: 40,
              color: Colors.black26,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: const Text("Intenta de nuevo"),
        )
      ],
    );
  }
}
