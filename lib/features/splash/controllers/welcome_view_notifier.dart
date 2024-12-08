// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/features/splash/utils/splash_contants.dart';

import 'package:ibank/features/splash/utils/splash_content.dart';

class WelcomeViewNotifier extends StateNotifier<WelcomeViewState> {
  WelcomeViewNotifier()
      : super(
          WelcomeViewState(
            contants: [
              welcomeSplashContent,
              transferSplashContent,
              securitySplashContent,
            ],
            currentContant: 0,
          ),
        ) {
    slide();
  }

  void slide({int? index}) async {
    await Future.delayed(const Duration(seconds: 3));
    if (index != null && index < state.contants.length) {
      state = state.copyWith(currentContant: state.currentContant + 1);
    } else if (state.currentContant < state.contants.length - 1) {
      state = state.copyWith(currentContant: state.currentContant + 1);
    } else {
      state = state.copyWith(currentContant: 0);
    }
    slide();
  }
}

class WelcomeViewState {
  final int currentContant;
  final List<SplashContent> contants;

  WelcomeViewState({required this.currentContant, required this.contants});

  WelcomeViewState copyWith({
    int? currentContant,
    List<SplashContent>? contants,
  }) {
    return WelcomeViewState(
      currentContant: currentContant ?? this.currentContant,
      contants: contants ?? this.contants,
    );
  }
}

final welcomeViewProvider =
    StateNotifierProvider<WelcomeViewNotifier, WelcomeViewState>(
  (ref) {
    return WelcomeViewNotifier();
  },
);
