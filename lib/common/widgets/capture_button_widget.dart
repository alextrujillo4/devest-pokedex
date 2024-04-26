import 'package:flutter/material.dart';

class CaptureWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  const CaptureWidget(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.amber,
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
                color: Colors.black,
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
