import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/features/splash/pages/welcome_page.dart';
import 'package:ibank/features/splash/utils/splash_contants.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/customs/pallete.dart';

class SecuritySplash extends ConsumerWidget {
  const SecuritySplash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSplashScreen(
      splash: Text(
        securitySplashContent.heading,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Pallete.white,
              fontWeight: FontWeight.w700,
            ),
      ),
      nextScreen: const WelcomePage(),
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Pallete.primary,
    );
  }
}
