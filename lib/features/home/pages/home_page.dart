import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/core/extensions/double_ext.dart';
import 'package:ibank/core/widgets/custom_elevated_button.dart';
import 'package:ibank/core/widgets/custom_outlined_button.dart';
import 'package:ibank/core/widgets/logo_title.dart';
import 'package:ibank/features/history/page/history_page.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';
import 'package:ibank/features/login/page/login_page.dart';
import 'package:ibank/features/transfer/page/transfer_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountStateCtrlProvider).account!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: LogoTitle(
                    text: 'Bal: R${account.balance.amount}',
                    textSize: 18,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Good day, ${account.firstName}!',
                  style: const TextStyle(
                    color: Pallete.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 15),
                CustomElevatedButton(
                  label: 'TRANSFER',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const TransferPage();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomElevatedButton(
                  label: 'HISTORY',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const HistoryPage();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                CustomOutlinedButton(
                  label: 'LOGOUT',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const LoginPage();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
