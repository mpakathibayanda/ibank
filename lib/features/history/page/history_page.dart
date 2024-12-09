import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/core/widgets/custom_outlined_button.dart';
import 'package:ibank/core/widgets/logo_title.dart';
import 'package:ibank/features/history/controller/history_state_ctrl.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getHistory = ref.watch(getHistoryProvider);
    final account = ref.read(accountStateCtrlProvider).account!;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: LogoTitle(text: 'HISTORY'),
                ),
                const SizedBox(height: 15),
                ...getHistory.when(
                  skipLoadingOnRefresh: false,
                  data: (transactions) {
                    return transactions.map(
                      (t) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            color: Colors.transparent,
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              title: Text(t.beneficiaryReference),
                              titleTextStyle: const TextStyle(
                                color: Pallete.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              tileColor: Pallete.weakBlue,
                              subtitle: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: [
                                  Text('${t.accountNumber} | '),
                                  Text(t.bank),
                                  Text(
                                    ' | ${t.transferDate?.substring(0, 10)}',
                                  ),
                                ],
                              ),
                              trailing: account.accountNumber == t.accountNumber
                                  ? Text(
                                      ' + R${t.amount}',
                                      style: const TextStyle(
                                        color: Pallete.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  : Text(
                                      ' - R${t.amount}',
                                      style: const TextStyle(
                                        color: Pallete.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  error: (e, s) {
                    return [
                      Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Pallete.white),
                      ),
                      const SizedBox(height: 30),
                      CustomOutlinedButton(
                        label: 'RELOAD',
                        onPressed: () {
                          ref.invalidate(getHistoryProvider);
                        },
                      ),
                    ];
                  },
                  loading: () {
                    return [
                      const Text(
                        'LOADING...',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Pallete.white),
                      ),
                    ];
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
