import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/data/transaction/usecases/history_usecase.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';

final getHistoryProvider = FutureProvider.autoDispose(
  (ref) async {
    final usecase = ref.watch(historyUsecaseProvider);
    final account = ref.read(accountStateCtrlProvider).account;
    if (account == null) throw ('Unautharized accesse, failed');
    final loginParams = LoginParams(
      username: account.email,
      password: account.password,
    );
    final res = await usecase(loginParams);
    return res.fold((error) => throw (error), (transactions) {
      transactions.sort((a, b) => a.transferDate!.compareTo(b.transferDate!));
      return transactions;
    });
  },
);
