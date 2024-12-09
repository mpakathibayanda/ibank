import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/data/account/sources/remote_account_datasource.dart';
import 'package:ibank/data/providers/http_client_prover.dart';

final remoteAccountRepoProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  return RemoteAccountDatasource(client: client);
});
