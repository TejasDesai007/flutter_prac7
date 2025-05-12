import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/BackgroundImage.jpg', // Replace with your background image
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
