// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/models/account_model.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/data/account/usecases/login_usecase.dart';

final accountStateCtrlProvider =
    StateNotifierProvider<AccountStateCtrl, AccountState>((ref) {
  return AccountStateCtrl(loginUsecase: ref.watch(loginUsecaseProvider));
});

class AccountStateCtrl extends StateNotifier<AccountState> {
  final LoginUsecase _loginUsecase;
  AccountStateCtrl({required LoginUsecase loginUsecase})
      : _loginUsecase = loginUsecase,
        super(
          AccountState(
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
    state = state.copyWith(isLoggin: true, error: '');
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
          (account) {
            state = state.copyWith(
              account: account.copyWith(password: details.password),
              error: '',
              isLoggin: false,
            );
            return true;
          },
        );
      },
    );
  }

  void setAmount(double value) {
    if (state.account == null) return;
    state = state.copyWith(
      account: state.account!.copyWith(
        balance: state.account!.balance + value,
      ),
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

class AccountState {
  final AccountModel? account;
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameCtrl;
  final TextEditingController passwordCtrl;
  final bool isLoggin;
  final String error;
  AccountState({
    this.account,
    required this.formKey,
    required this.usernameCtrl,
    required this.passwordCtrl,
    required this.isLoggin,
    required this.error,
  });

  AccountState copyWith({
    GlobalKey<FormState>? formKey,
    AccountModel? account,
    TextEditingController? usernameCtrl,
    TextEditingController? passwordCtrl,
    bool? isLoggin,
    String? error,
  }) {
    return AccountState(
      account: account ?? this.account,
      formKey: formKey ?? this.formKey,
      usernameCtrl: usernameCtrl ?? this.usernameCtrl,
      passwordCtrl: passwordCtrl ?? this.passwordCtrl,
      isLoggin: isLoggin ?? this.isLoggin,
      error: error ?? this.error,
    );
  }
}
