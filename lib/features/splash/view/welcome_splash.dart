import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/features/splash/utils/splash_contants.dart';
import 'package:ibank/features/splash/view/transfer_splash.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeSplash extends ConsumerWidget {
  const WelcomeSplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSplashScreen(
      splash: Text(
        welcomeSplashContent.heading,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Pallete.white,
              fontWeight: FontWeight.w700,
            ),
      ),
      nextScreen: const TransferSplash(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Pallete.primary,
    );
  }
}
