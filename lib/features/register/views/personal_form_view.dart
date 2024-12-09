import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/features/register/controller/personal_details_state_ctrl.dart';
import 'package:ibank/features/register/views/current_form_view.dart';

class PersonalFormView extends ConsumerWidget {
  const PersonalFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(personalDetailsStateCtrlProvider);
    return CurrentFormView(
      formTitle: 'Personal Details',
      formKey: state.formKey,
      formFields: [
        CustomTextFormField(
          controller: state.firstNameCtrl,
          //enabled: !state.isLoggin,
          hint: 'FISRT NAME',
          keyboardType: TextInputType.name,
          validator: firstNameValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.lastNameCtrl,
          //enabled: !state.isLoggin,
          hint: 'LAST NAME',
          keyboardType: TextInputType.name,
          validator: lastNameValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.idNumberCtrl,
          //enabled: !state.isLoggin,
          hint: 'ID NUMBER',
          keyboardType: TextInputType.number,
          validator: idNumberValidation,
        ),
      ],
    );
  }
}
