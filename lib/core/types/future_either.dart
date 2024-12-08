import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<String, T>>;
typedef FutureEitherVoid = FutureEither<void>;
