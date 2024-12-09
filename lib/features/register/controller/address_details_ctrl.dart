// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressDetailsStateCtrlProvider =
    StateNotifierProvider<AddressDetailsStateCtrl, AddressDetailsState>(
  (ref) {
    return AddressDetailsStateCtrl();
  },
);

class AddressDetailsStateCtrl extends StateNotifier<AddressDetailsState> {
  AddressDetailsStateCtrl()
      : super(
          AddressDetailsState(
            formKey: GlobalKey<FormState>(),
            provinceCtrl: TextEditingController(),
            suburbCtrl: TextEditingController(),
            cityCtrl: TextEditingController(),
            streetNumberCtrl: TextEditingController(),
            streetNameCtrl: TextEditingController(),
          ),
        );

  bool next() {
    return state.formKey.currentState!.validate();
  }

  void setProvince(String province) {
    state = state.copyWith(
      provinceCtrl: TextEditingController(text: province),
    );
  }

  Map<String, dynamic> get details => {
        'province': state.provinceCtrl.text,
        'suburb': state.suburbCtrl.text,
        'city': state.cityCtrl.text,
        'streetName': state.streetNameCtrl.text,
        'streetNumber': state.streetNumberCtrl.text,
      };

  void clear() {
    state.provinceCtrl.clear();
    state.suburbCtrl.clear();
    state.cityCtrl.clear();
    state.streetNameCtrl.clear();
    state.streetNumberCtrl.clear();
    state.formKey.currentState?.reset();
  }

  @override
  void dispose() {
    state.provinceCtrl.dispose();
    state.suburbCtrl.dispose();
    state.cityCtrl.dispose();
    state.streetNameCtrl.dispose();
    state.streetNumberCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class AddressDetailsState {
  final GlobalKey<FormState> formKey;
  final TextEditingController provinceCtrl;
  final TextEditingController suburbCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController streetNumberCtrl;
  final TextEditingController streetNameCtrl;

  AddressDetailsState(
      {required this.formKey,
      required this.provinceCtrl,
      required this.suburbCtrl,
      required this.cityCtrl,
      required this.streetNumberCtrl,
      required this.streetNameCtrl});

  AddressDetailsState copyWith({
    GlobalKey<FormState>? formKey,
    TextEditingController? provinceCtrl,
    TextEditingController? suburbCtrl,
    TextEditingController? cityCtrl,
    TextEditingController? streetNumberCtrl,
    TextEditingController? streetNameCtrl,
  }) {
    return AddressDetailsState(
      formKey: formKey ?? this.formKey,
      provinceCtrl: provinceCtrl ?? this.provinceCtrl,
      suburbCtrl: suburbCtrl ?? this.suburbCtrl,
      cityCtrl: cityCtrl ?? this.cityCtrl,
      streetNumberCtrl: streetNumberCtrl ?? this.streetNumberCtrl,
      streetNameCtrl: streetNameCtrl ?? this.streetNameCtrl,
    );
  }
}
