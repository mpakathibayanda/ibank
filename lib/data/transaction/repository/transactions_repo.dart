import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/models/transaction_model.dart';
import 'package:ibank/core/types/future_either.dart';

abstract interface class TransactionsRepo {
  FutureEither<TransactionModel> transfer({
    required LoginParams loginParams,
    required TransactionModel transaction,
  });

  FutureEither<List<TransactionModel>> getHistory(
      {required LoginParams loginParams});
}
