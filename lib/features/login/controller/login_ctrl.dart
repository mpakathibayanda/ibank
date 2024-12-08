// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/data/account/usecases/login_usecase.dart';

final loginStateCtrlProvider =
    StateNotifierProvider<LoginStateCtrl, LoginState>((ref) {
  return LoginStateCtrl(loginUsecase: ref.watch(loginUsecaseProvider));
});

class LoginStateCtrl extends StateNotifier<LoginState> {
  final LoginUsecase _loginUsecase;
  LoginStateCtrl({required LoginUsecase loginUsecase})
      : _loginUsecase = loginUsecase,
        super(
          LoginState(
            formKey: GlobalKey<FormState>(),
            usernameCtrl: TextEditingController(),
            passwordCtrl: TextEditingController(),
            isLoggin: false,
            error: '',
          ),
        );
  Future<bool> login() async {
    if (!state.formKey.currentState!.validate()) {
      return false;
    }
    state = state.copyWith(isLoggin: true);
    final details = LoginParams(
      username: state.usernameCtrl.text,
      password: state.passwordCtrl.text,
    );
    return await _loginUsecase(details).then(
      (res) {
        return res.fold(
          (error) {
            state = state.copyWith(error: error, isLoggin: false);
            return false;
          },
          (_) {
            state = state.copyWith(error: '', isLoggin: false);
            return true;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    state.usernameCtrl.dispose();
    state.passwordCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class LoginState {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameCtrl;
  final TextEditingController passwordCtrl;
  final bool isLoggin;
  final String error;
  LoginState({
    required this.formKey,
    required this.usernameCtrl,
    required this.passwordCtrl,
    required this.isLoggin,
    required this.error,
  });

  LoginState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? usernameCtrl,
    TextEditingController? passwordCtrl,
    bool? isLoggin,
    String? error,
  }) {
    return LoginState(
      formKey: formKey ?? this.formKey,
      usernameCtrl: usernameCtrl ?? this.usernameCtrl,
      passwordCtrl: passwordCtrl ?? this.passwordCtrl,
      isLoggin: isLoggin ?? this.isLoggin,
      error: error ?? this.error,
    );
  }
}
