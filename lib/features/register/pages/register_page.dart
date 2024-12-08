import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/widgets/custom_elevated_button.dart';
import 'package:ibank/core/widgets/custom_outlined_button.dart';
import 'package:ibank/features/login/page/login_page.dart';
import 'package:ibank/features/register/controller/register_forms_state_ctrl.dart';
import 'package:ibank/features/register/views/address_form_view.dart';
import 'package:ibank/features/register/views/contact_form_view.dart';
import 'package:ibank/features/register/views/password_form_view.dart';
import 'package:ibank/features/register/views/personal_form_view.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerFormsStateCtrlProvider);
    final notifier = ref.read(registerFormsStateCtrlProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                switch (state) {
                  0 => const PersonalFormView(),
                  1 => const AddressFormView(),
                  2 => const ContactFormView(),
                  3 => const PasswordFormView(),
                  _ => const SizedBox.shrink()
                },
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: state > 0,
                      child: CustomOutlinedButton(
                        label: 'Prevous',
                        onPressed: () => notifier.prevous(),
                        size: const Size(150, 50),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomElevatedButton(
                      label: state != 3 ? 'Next' : 'Register',
                      onPressed: () => notifier.next(),
                      size: const Size(150, 50),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Text('Alreagy have an account? '),
                    InkWell(
                      onTap: () {
                        try {
                          Navigator.pop(context);
                        } on Exception catch (_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
