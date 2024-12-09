import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

class LogoTitle extends StatelessWidget {
  final String text;
  final double? size;
  final double? textSize;
  const LogoTitle({super.key, required this.text, this.size, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 50,
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(size != null ? (size! / 4) : 50),
          ),
          child: Image.asset(
            'assets/logo.png',
            height: size ?? 200,
            width: size ?? 200,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Pallete.white,
                fontWeight: FontWeight.w700,
                fontSize: textSize,
              ),
        ),
      ],
    );
  }
}
