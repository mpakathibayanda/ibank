import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/app_theme_data.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:page_transition/page_transition.dart';

import 'package:ibank/features/splash/view/transfer_splash.dart';
import 'package:ibank/features/splash/view/welcome_splash.dart';

import 'core/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode && !isMobile,
      builder: (context) => const ProviderScope(child: MyApp()),
      tools: const [
        ...DevicePreview.defaultTools,
        DevicePreviewScreenshot(),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iBank',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: appThemeData,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: const WelcomeSplash(),
        nextScreen: const TransferSplash(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Pallete.primary,
      ),
    );
  }
}
