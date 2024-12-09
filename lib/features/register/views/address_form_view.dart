import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/features/register/controller/address_details_ctrl.dart';
import 'package:ibank/features/register/views/current_form_view.dart';
import 'package:ibank/features/register/widgets/provinces_dropdown.dart';

class AddressFormView extends ConsumerWidget {
  const AddressFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addressDetailsStateCtrlProvider);
    return CurrentFormView(
      formTitle: 'Address Details',
      formKey: state.formKey,
      formFields: [
        const ProvincesDropdown(),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.suburbCtrl,
          //enabled: !state.isLoggin,
          hint: 'SUBURB',
          keyboardType: TextInputType.name,
          validator: requiredValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.cityCtrl,
          //enabled: !state.isLoggin,
          hint: 'CITY',
          keyboardType: TextInputType.name,
          validator: requiredValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.streetNameCtrl,
          //enabled: !state.isLoggin,
          hint: 'STREET NAME',
          keyboardType: TextInputType.name,
          validator: requiredValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.streetNumberCtrl,
          //enabled: !state.isLoggin,
          hint: 'STREET NUMBER',
          keyboardType: TextInputType.name,
          validator: requiredValidation,
        ),
      ],
    );
  }
}
