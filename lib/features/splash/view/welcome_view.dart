import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/features/splash/controllers/welcome_view_notifier.dart';
import 'package:ibank/features/splash/widgets/app_splash.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(welcomeViewProvider);
    return AppSplash(content: state.contants[state.currentContant]);
  }
}
