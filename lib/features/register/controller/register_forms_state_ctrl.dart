// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ibank/core/models/account_model.dart';
import 'package:ibank/data/account/usecases/register_usecase.dart';
import 'package:ibank/features/register/controller/address_details_ctrl.dart';
import 'package:ibank/features/register/controller/contact_details_state_ctrl.dart';
import 'package:ibank/features/register/controller/password_details_ctrl.dart';
import 'package:ibank/features/register/controller/personal_details_state_ctrl.dart';

final registerFormsStateCtrlProvider =
    StateNotifierProvider.autoDispose<RegisterFormsStateCtrl, RegisterState>(
  (ref) {
    final registerUsecase = ref.watch(registerUsecaseProvider);
    return RegisterFormsStateCtrl(ref, registerUsecase: registerUsecase);
  },
);

class RegisterFormsStateCtrl extends StateNotifier<RegisterState> {
  final RegisterUsecase _registerUsecase;
  final Ref _ref;
  RegisterFormsStateCtrl(
    Ref ref, {
    required RegisterUsecase registerUsecase,
  })  : _registerUsecase = registerUsecase,
        _ref = ref,
        super(
          RegisterState(
            currentFormIndex: 0,
            isRegisting: false,
          ),
        );

  Future<bool> next() async {
    switch (state.currentFormIndex) {
      case 0:
        final valid =
            _ref.read(personalDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state.copyWith(currentFormIndex: state.currentFormIndex + 1);
        }
        break;
      case 1:
        final valid =
            _ref.read(addressDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state.copyWith(currentFormIndex: state.currentFormIndex + 1);
        }
        break;
      case 2:
        final valid =
            _ref.read(contactDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state.copyWith(currentFormIndex: state.currentFormIndex + 1);
        }
      case 3:
        final valid =
            _ref.read(passwordDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          return await _register();
        }
        return false;
    }

    return false;
  }

  void prevous() {
    state = state.copyWith(currentFormIndex: state.currentFormIndex - 1);
  }

  AccountModel _getAccount() {
    Map<String, dynamic> data = {}
      ..addAll(
        _ref.read(personalDetailsStateCtrlProvider.notifier).details,
      )
      ..addAll(
        _ref.read(addressDetailsStateCtrlProvider.notifier).details,
      )
      ..addAll(
        _ref.read(contactDetailsStateCtrlProvider.notifier).details,
      )
      ..addAll(
        _ref.read(passwordDetailsStateCtrlProvider.notifier).details,
      )
      ..addAll({'balance': 221675.32});
    // print("Data: $data");
    return AccountModel.fromMap(data);
  }

  Future<bool> _register() async {
    try {
      state = state.copyWith(isRegisting: true, error: '');
      return await _registerUsecase(_getAccount()).then(
        (res) {
          return res.fold(
            (l) {
              state = state.copyWith(
                isRegisting: false,
                error: l.isNotEmpty ? l : 'Unknown error',
              );
              return false;
            },
            (r) {
              state = state.copyWith(
                error: null,
                isRegisting: false,
                currentFormIndex: 0,
              );
              _clear();
              return true;
            },
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isRegisting: false,
        error: e.toString().isNotEmpty ? e.toString() : 'Unknown error accured',
      );
      return false;
    }
  }

  void setError(String? value) {
    state = state.copyWith(error: value ?? '');
  }

  void _clear() {
    _ref.read(personalDetailsStateCtrlProvider.notifier).clear();
    _ref.read(addressDetailsStateCtrlProvider.notifier).clear();
    _ref.read(contactDetailsStateCtrlProvider.notifier).clear();
    _ref.read(passwordDetailsStateCtrlProvider.notifier).clear();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }
}

class RegisterState {
  final int currentFormIndex;
  final bool isRegisting;
  final String error;

  RegisterState({
    required this.currentFormIndex,
    required this.isRegisting,
    this.error = '',
  });

  RegisterState copyWith({
    int? currentFormIndex,
    bool? isRegisting,
    String? error,
  }) {
    return RegisterState(
      currentFormIndex: currentFormIndex ?? this.currentFormIndex,
      isRegisting: isRegisting ?? this.isRegisting,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'RegisterState(currentFormIndex: $currentFormIndex, isRegisting: $isRegisting, error: $error)';
}
