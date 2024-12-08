import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/data/account/sources/remote_account_datasource.dart';

final remoteAccountRepoProvider = Provider((ref) {
  return RemoteAccountDatasource();
});
