import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/core/extensions/build_context_ext.dart';
import 'package:ibank/core/extensions/double_ext.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/widgets/custom_elevated_button.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/core/widgets/logo_title.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';
import 'package:ibank/features/transfer/controller/transfer_state_ctrl.dart';
import 'package:ibank/features/transfer/widgets/banks_dropdown.dart';

class TransferPage extends ConsumerWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountStateCtrlProvider).account!;
    final state = ref.watch(transferStateCtrlProvider);
    final notifier = ref.read(transferStateCtrlProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: LogoTitle(
                      text: 'Bal: R${account.balance.amount}',
                      size: 100,
                      textSize: 18,
                    ),
                  ),
                  const TransferErrorView(),
                  const SizedBox(height: 15),
                  const BanksDropdown(),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: state.accountNameCtrl,
                    enabled: !state.isTransfering,
                    hint: 'ACCOUNT NAME',
                    keyboardType: TextInputType.name,
                    validator: accountNameValidation,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: state.accountNumberCtrl,
                    enabled: !state.isTransfering,
                    hint: 'ACCOUNT NUMBER',
                    keyboardType: TextInputType.number,
                    validator: accountNumberValidation,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: state.beneficiaryReferenceCtrl,
                    enabled: !state.isTransfering,
                    hint: 'BANEFICIARY REFERENCE',
                    keyboardType: TextInputType.name,
                    validator: requiredValidation,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: state.amountCtrl,
                    enabled: !state.isTransfering,
                    hint: 'AMOUNT',
                    keyboardType: TextInputType.number,
                    validator: amountValidation,
                    prefixText: 'R',
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    label: 'TRANSFER NOW',
                    onPressed: !state.isTransfering
                        ? () async {
                            final sure = await context.sureDialog(
                              text:
                                  'You to transfer R${state.amountCtrl.text} to ${state.accountNumberCtrl.text}?',
                            );
                            if (!sure) return;
                            final res = await notifier.transfer(
                              LoginParams(
                                username: account.email,
                                password: account.password,
                              ),
                            );
                            if (res && state.error.isEmpty) {
                              context.snackBar(
                                msg: 'Succefully transferred',
                                color: Pallete.green,
                                textColor: Pallete.white,
                              );
                              Navigator.pop(context);
                            } else if (state.error.isNotEmpty) {
                              context.snackBar(
                                msg: state.error,
                                color: Pallete.red,
                                textColor: Pallete.white,
                              );
                              notifier.setError('');
                            }
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransferErrorView extends ConsumerWidget {
  const TransferErrorView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final error = ref.watch(transferStateCtrlProvider).error;
    return Visibility(
      visible: error.isNotEmpty,
      child: Column(
        children: [
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
