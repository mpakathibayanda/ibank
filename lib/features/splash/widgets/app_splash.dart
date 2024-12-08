import 'package:flutter/material.dart';
import 'package:ibank/features/splash/utils/splash_content.dart';

import '../../../core/customs/pallete.dart';

class AppSplash extends StatelessWidget {
  final SplashContent? content;
  const AppSplash({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return content != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content!.heading,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Pallete.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 25),
              Text(
                content!.body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Pallete.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
