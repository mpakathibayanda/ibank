import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        gradient: Pallete.gradient,
      ),
      child: child,
    );
  }
}
