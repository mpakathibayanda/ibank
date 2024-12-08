import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/features/splash/utils/splash_contants.dart';
import 'package:ibank/features/splash/view/security_splash.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/customs/pallete.dart';

class TransferSplash extends ConsumerWidget {
  const TransferSplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSplashScreen(
      splash: Text(
        transferSplashContent.heading,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Pallete.white,
              fontWeight: FontWeight.w700,
            ),
      ),
      nextScreen: const SecuritySplash(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Pallete.primary,
    );
  }
}
