// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/features/register/controller/address_details_ctrl.dart';
import 'package:ibank/features/register/controller/contact_details_state_ctrl.dart';
import 'package:ibank/features/register/controller/password_details_ctrl.dart';
import 'package:ibank/features/register/controller/personal_details_state_ctrl.dart';

final registerFormsStateCtrlProvider =
    StateNotifierProvider<RegisterFormsStateCtrl, int>(
  (ref) {
    return RegisterFormsStateCtrl(ref);
  },
);

class RegisterFormsStateCtrl extends StateNotifier<int> {
  final Ref _ref;
  RegisterFormsStateCtrl(Ref ref)
      : _ref = ref,
        super(3);

  void next() {
    switch (state) {
      case 0:
        final valid =
            _ref.read(personalDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state + 1;
        }
        break;
      case 1:
        final valid =
            _ref.read(addressDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state + 1;
        }
        break;
      case 2:
        final valid =
            _ref.read(contactDetailsStateCtrlProvider.notifier).next();
        if (valid) {
          state = state + 1;
        }
      case 3:
        final valid =
            _ref.read(passwordDetailsStateCtrlProvider.notifier).next();

        print(valid);
        if (valid) {
          register();
        }
        break;
    }
  }

  void prevous() {
    state = state - 1;
  }

  void register() {
    print('Register...');
  }
}
