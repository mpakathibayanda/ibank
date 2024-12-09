// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordDetailsStateCtrlProvider =
    StateNotifierProvider<PasswordDetailsStateCtrl, PasswordDetailsState>(
  (ref) {
    return PasswordDetailsStateCtrl();
  },
);

class PasswordDetailsStateCtrl extends StateNotifier<PasswordDetailsState> {
  PasswordDetailsStateCtrl()
      : super(
          PasswordDetailsState(
            formKey: GlobalKey<FormState>(),
            createPasswordCtrl: TextEditingController(),
            confirmPasswordCtrl: TextEditingController(),
          ),
        );

  bool next() => state.formKey.currentState!.validate();

  Map<String, dynamic> get details =>
      {'password': state.createPasswordCtrl.text};

  void clear() {
    state.createPasswordCtrl.clear();
    state.confirmPasswordCtrl.clear();
    state.formKey.currentState?.reset();
  }

  @override
  void dispose() {
    state.createPasswordCtrl.dispose();
    state.confirmPasswordCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class PasswordDetailsState {
  final GlobalKey<FormState> formKey;
  final TextEditingController createPasswordCtrl;
  final TextEditingController confirmPasswordCtrl;

  PasswordDetailsState({
    required this.formKey,
    required this.createPasswordCtrl,
    required this.confirmPasswordCtrl,
  });

  PasswordDetailsState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? createPasswordCtrl,
    TextEditingController? confirmPasswordCtrl,
  }) {
    return PasswordDetailsState(
      formKey: formKey ?? this.formKey,
      createPasswordCtrl: createPasswordCtrl ?? this.createPasswordCtrl,
      confirmPasswordCtrl: confirmPasswordCtrl ?? this.confirmPasswordCtrl,
    );
  }
}
