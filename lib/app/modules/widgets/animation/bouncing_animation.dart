// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BouncingAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const BouncingAnimation({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BouncingAnimationState createState() => _BouncingAnimationState();
}

class _BouncingAnimationState extends State<BouncingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
          scale: _tween.animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            ),
          ),
          child: widget.child),
    );
  }
}
