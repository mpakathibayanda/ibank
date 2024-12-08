import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/features/register/controller/password_details_ctrl.dart';
import 'package:ibank/features/register/views/current_form_view.dart';

class PasswordFormView extends ConsumerWidget {
  const PasswordFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordDetailsStateCtrlProvider);
    return CurrentFormView(
      formTitle: 'Password Details',
      formKey: state.formKey,
      formFields: [
        CustomTextFormField(
          controller: state.createPasswordCtrl,
          //enabled: !state.isLoggin,
          hint: 'CREATE PASSWORD',
          keyboardType: TextInputType.name,
          isPassword: true,
          validator: passwordValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.confirmPasswordCtrl,
          //enabled: !state.isLoggin,
          hint: 'CONFIRM PASSWORD',
          keyboardType: TextInputType.name,
          isPassword: true,
          validator: (value) {
            return matchingPasswordValidation(
              state.createPasswordCtrl.text,
              value,
            );
          },
        ),
      ],
    );
  }
}
