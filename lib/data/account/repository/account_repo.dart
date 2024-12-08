import 'package:ibank/core/types/future_either.dart';

import '../../../core/models/account_model.dart';

abstract interface class AccountRepo {
  FutureEitherVoid register({required AccountModel account});
  FutureEitherVoid login({required String username, required String password});
}
