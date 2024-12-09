import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/core/extensions/build_context_ext.dart';
import 'package:ibank/core/helpers/validators.dart';
import 'package:ibank/core/widgets/custom_elevated_button.dart';
import 'package:ibank/core/widgets/custom_text_form_field.dart';
import 'package:ibank/core/widgets/logo_title.dart';
import 'package:ibank/features/home/pages/home_page.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';
import 'package:ibank/features/register/pages/register_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountStateCtrlProvider);
    final notifier = ref.read(accountStateCtrlProvider.notifier);
    return Scaffold(
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
                  const Align(
                    alignment: Alignment.center,
                    child: LogoTitle(text: 'iBANK LOGIN'),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Use an email or cellphone number as a username',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 60),
                  const LoginErrorView(),
                  CustomTextFormField(
                    controller: state.usernameCtrl,
                    enabled: !state.isLoggin,
                    hint: 'USERNAME',
                    keyboardType: TextInputType.emailAddress,
                    validator: usernameValidation,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: state.passwordCtrl,
                    enabled: !state.isLoggin,
                    hint: 'PASSWORD',
                    validator: passwordValidation,
                    isPassword: true,
                  ),
                  const SizedBox(height: 15),
                  CustomElevatedButton(
                    label: !state.isLoggin ? 'LOGIN' : 'LOGIN...',
                    onPressed: !state.isLoggin
                        ? () async {
                            final isLoggedIn = await notifier.login();
                            if (isLoggedIn) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage();
                                  },
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              context.snackBar(
                                msg: state.error,
                                color: Pallete.red,
                                textColor: Pallete.white,
                              );
                            }
                          }
                        : null,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      const Text('Do\'nt have an account? '),
                      InkWell(
                        onTap: !state.isLoggin
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const RegisterPage();
                                    },
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          'Register',
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
      ),
    );
  }
}

class LoginErrorView extends ConsumerWidget {
  const LoginErrorView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final error = ref.watch(accountStateCtrlProvider).error;
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
