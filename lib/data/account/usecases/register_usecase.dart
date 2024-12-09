import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ibank/core/models/account_model.dart';
import 'package:ibank/data/account/repository/account_repo.dart';
import 'package:ibank/data/account/sources/account_source_providers.dart';

import '../../../core/usecases/usecases.dart';

class RegisterUsecase implements ParamsUsecase<void, AccountModel> {
  final AccountRepo _accountRepo;

  RegisterUsecase({required AccountRepo accountRepo})
      : _accountRepo = accountRepo;
  @override
  Future<Either<String, void>> call(AccountModel account) async {
    return await _accountRepo.register(account: account);
  }
}

final registerUsecaseProvider = Provider((ref) {
  final accountRepo = ref.watch(remoteAccountRepoProvider);
  return RegisterUsecase(accountRepo: accountRepo);
});
