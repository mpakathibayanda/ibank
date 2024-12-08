import 'package:fpdart/fpdart.dart';

abstract interface class ParamsUsecase<Success, Params> {
  Future<Either<String, Success>> call(Params params);
}

abstract interface class NoParamsUsecase<Success> {
  Future<Either<String, Success>> call();
}
