import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/models/transaction_model.dart';
import 'package:ibank/data/transaction/repository/transactions_repo.dart';
import 'package:ibank/data/transaction/sources/transactions_source_providers.dart';

import '../../../core/usecases/usecases.dart';

class TransferUsecase
    implements ParamsUsecase<TransactionModel, TransferUsecaseParams> {
  final TransactionsRepo _transactionsRepo;

  TransferUsecase({required TransactionsRepo transactionsRepo})
      : _transactionsRepo = transactionsRepo;
  @override
  Future<Either<String, TransactionModel>> call(
    TransferUsecaseParams transferUsecaseParams,
  ) async {
    return await _transactionsRepo.transfer(
        loginParams: transferUsecaseParams.loginParams,
        transaction: transferUsecaseParams.transaction);
  }
}

class TransferUsecaseParams {
  final LoginParams loginParams;
  final TransactionModel transaction;

  TransferUsecaseParams({required this.loginParams, required this.transaction});
}

final transferUsecaseProvider = Provider((ref) {
  final transactionsRepo = ref.watch(remoteTransactionsRepoProvider);
  return TransferUsecase(transactionsRepo: transactionsRepo);
});
