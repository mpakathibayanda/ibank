import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/models/transaction_model.dart';
import 'package:ibank/data/transaction/repository/transactions_repo.dart';
import 'package:ibank/data/transaction/sources/transactions_source_providers.dart';

import '../../../core/usecases/usecases.dart';

class HistoryUsecase
    implements ParamsUsecase<List<TransactionModel>, LoginParams> {
  final TransactionsRepo _transactionsRepo;

  HistoryUsecase({required TransactionsRepo transactionsRepo})
      : _transactionsRepo = transactionsRepo;
  @override
  Future<Either<String, List<TransactionModel>>> call(
      LoginParams loginParams) async {
    return await _transactionsRepo.getHistory(loginParams: loginParams);
  }
}

final historyUsecaseProvider = Provider((ref) {
  final transactionsRepo = ref.watch(remoteTransactionsRepoProvider);
  return HistoryUsecase(transactionsRepo: transactionsRepo);
});
