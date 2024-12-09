import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/data/providers/http_client_prover.dart';
import 'package:ibank/data/transaction/sources/remote_transactions_datasource.dart';

final remoteTransactionsRepoProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  return RemoteTransactionsDatasource(client: client);
});
