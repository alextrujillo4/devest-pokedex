import 'package:flutter/material.dart';

class CaptureWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final Color? background;

  const CaptureWidget({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: background ?? Colors.black.withOpacity(0.1),
      child: SizedBox(
        height: 62,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5), // Adjust spacing as needed
            icon,
          ],
        ),
      ),
    );
  }
}
