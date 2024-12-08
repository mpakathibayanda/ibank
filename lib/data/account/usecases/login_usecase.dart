import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/usecases/usecases.dart';
import 'package:ibank/data/account/repository/account_repo.dart';
import 'package:ibank/data/account/sources/source_providers.dart';

class LoginUsecase implements ParamsUsecase<void, LoginParams> {
  final AccountRepo _accountRepo;

  LoginUsecase({required AccountRepo accountRepo}) : _accountRepo = accountRepo;
  @override
  Future<Either<String, void>> call(LoginParams details) async {
    return await _accountRepo.login(
      username: details.username,
      password: details.password,
    );
  }
}

final loginUsecaseProvider = Provider((ref) {
  final accountRepo = ref.watch(remoteAccountRepoProvider);
  return LoginUsecase(accountRepo: accountRepo);
});
