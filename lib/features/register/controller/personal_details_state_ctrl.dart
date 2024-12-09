// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalDetailsStateCtrlProvider =
    StateNotifierProvider<PersonalDetailsStateCtrl, PersonalDetailsState>(
  (ref) {
    return PersonalDetailsStateCtrl();
  },
);

class PersonalDetailsStateCtrl extends StateNotifier<PersonalDetailsState> {
  PersonalDetailsStateCtrl()
      : super(
          PersonalDetailsState(
            formKey: GlobalKey<FormState>(),
            firstNameCtrl: TextEditingController(),
            lastNameCtrl: TextEditingController(),
            idNumberCtrl: TextEditingController(),
          ),
        );

  bool next() => state.formKey.currentState!.validate();
  Map<String, dynamic> get details => {
        'firstName': state.firstNameCtrl.text,
        'lastName': state.lastNameCtrl.text,
        'idNumber': state.idNumberCtrl.text,
      };

  void clear() {
    state.firstNameCtrl.clear();
    state.lastNameCtrl.clear();
    state.idNumberCtrl.clear();
    state.formKey.currentState?.reset();
  }

  @override
  void dispose() {
    state.firstNameCtrl.dispose();
    state.lastNameCtrl.dispose();
    state.idNumberCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class PersonalDetailsState {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController idNumberCtrl;

  PersonalDetailsState(
      {required this.formKey,
      required this.firstNameCtrl,
      required this.lastNameCtrl,
      required this.idNumberCtrl});

  PersonalDetailsState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? firstNameCtrl,
    TextEditingController? lastNameCtrl,
    TextEditingController? idNumberCtrl,
  }) {
    return PersonalDetailsState(
      formKey: formKey ?? this.formKey,
      firstNameCtrl: firstNameCtrl ?? this.firstNameCtrl,
      lastNameCtrl: lastNameCtrl ?? this.lastNameCtrl,
      idNumberCtrl: idNumberCtrl ?? this.idNumberCtrl,
    );
  }
}
