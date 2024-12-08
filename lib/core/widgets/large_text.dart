import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

class LargeText extends StatelessWidget {
  final String text;
  const LargeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 50,
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset('assets/logo.png', height: 200, width: 200),
        ),
        const SizedBox(height: 15),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Pallete.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
