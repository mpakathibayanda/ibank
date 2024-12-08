import 'package:flutter/material.dart';
import 'package:ibank/core/widgets/custom_elevated_button.dart';
import 'package:ibank/core/widgets/custom_outlined_button.dart';
import 'package:ibank/core/widgets/gradient_container.dart';
import 'package:ibank/features/login/page/login_page.dart';
import 'package:ibank/features/register/pages/register_page.dart';
import 'package:ibank/features/splash/view/welcome_view.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: WelcomeView()),
                Wrap(
                  spacing: 25,
                  runSpacing: 15,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    CustomElevatedButton(
                      label: 'Login',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const LoginPage();
                            },
                          ),
                        );
                      },
                    ),
                    CustomOutlinedButton(
                      label: 'Register',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
