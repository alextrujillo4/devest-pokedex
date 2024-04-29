import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageAsset;

  const AnimatedFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.imageAsset,
  });

  @override
  State<AnimatedFloatingActionButton> createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 6));
    _rotationAnimation = Tween<double>(begin: 0.0, end: 3.14 * 4).animate(_animationController); // Rotates full circle twice
    _animationController.forward(); // Start animation on widget creation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white.withAlpha(0),
      onPressed: widget.onPressed,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        child: Image.asset(widget.imageAsset),
        builder: (context, child) => Transform.rotate(
          angle: _rotationAnimation.value,
          child: child,
        ),
      ),
    );
  }
}
