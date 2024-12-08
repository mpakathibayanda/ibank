import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/core/extensions/build_context_ext.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Size? size;
  const CustomOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Pallete.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(color: Pallete.white),
        fixedSize: size ?? Size(context.width - 12, 50),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Pallete.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
