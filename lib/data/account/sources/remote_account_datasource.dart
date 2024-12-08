import 'package:ibank/core/models/account_model.dart';
import 'package:ibank/core/types/future_either.dart';
import 'package:ibank/data/account/repository/account_repo.dart';

class RemoteAccountDatasource implements AccountRepo {
  @override
  FutureEitherVoid login({required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  FutureEitherVoid register({required AccountModel account}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
