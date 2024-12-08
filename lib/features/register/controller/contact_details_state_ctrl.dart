// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactDetailsStateCtrlProvider =
    StateNotifierProvider<ContactDetailsStateCtrl, ContactDetailsState>(
  (ref) {
    return ContactDetailsStateCtrl();
  },
);

class ContactDetailsStateCtrl extends StateNotifier<ContactDetailsState> {
  ContactDetailsStateCtrl()
      : super(
          ContactDetailsState(
            formKey: GlobalKey<FormState>(),
            emailAddressCtrl: TextEditingController(),
            cellphoneNumberCtrl: TextEditingController(),
          ),
        );

  bool next() => state.formKey.currentState!.validate();

  @override
  void dispose() {
    state.emailAddressCtrl.dispose();
    state.cellphoneNumberCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class ContactDetailsState {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailAddressCtrl;
  final TextEditingController cellphoneNumberCtrl;

  ContactDetailsState(
      {required this.formKey,
      required this.emailAddressCtrl,
      required this.cellphoneNumberCtrl});

  ContactDetailsState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? emailAddressCtrl,
    TextEditingController? cellphoneNumberCtrl,
  }) {
    return ContactDetailsState(
      formKey: formKey ?? this.formKey,
      emailAddressCtrl: emailAddressCtrl ?? this.emailAddressCtrl,
      cellphoneNumberCtrl: cellphoneNumberCtrl ?? this.cellphoneNumberCtrl,
    );
  }
}
