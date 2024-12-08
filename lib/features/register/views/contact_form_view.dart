import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/features/register/controller/contact_details_state_ctrl.dart';
import 'package:ibank/features/register/views/current_form_view.dart';

class ContactFormView extends ConsumerWidget {
  const ContactFormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactDetailsStateCtrlProvider);
    return CurrentFormView(
      formTitle: 'Contact Details',
      formKey: state.formKey,
      formFields: [
        CustomTextFormField(
          controller: state.emailAddressCtrl,
          //enabled: !state.isLoggin,
          hint: 'EMAIL ADDRES',
          keyboardType: TextInputType.name,
          validator: emailValidation,
        ),
        const SizedBox(height: 10),
        CustomTextFormField(
          controller: state.cellphoneNumberCtrl,
          //enabled: !state.isLoggin,
          hint: 'CELLPHONE NUMBER',
          keyboardType: TextInputType.name,
          validator: cellphoneValidation,
        ),
      ],
    );
  }
}
