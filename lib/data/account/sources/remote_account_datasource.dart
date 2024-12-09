import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/core/models/account_model.dart';
import 'package:ibank/core/types/future_either.dart';
import 'package:ibank/data/account/repository/account_repo.dart';
import 'package:ibank/data/constants/data_constants.dart';

class RemoteAccountDatasource implements AccountRepo {
  final http.Client _client;

  RemoteAccountDatasource({required http.Client client}) : _client = client;
  @override
  FutureEither<AccountModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse('${DataConstants.baseUrl}/login');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({"username": username, "password": password});

      final response = await _client.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonRes = response.body;
        final account = AccountModel.fromJson(jsonRes);
        return right(account);
      } else if (response.statusCode == 401) {
        return left('Invalid creditials');
      } else if (response.statusCode >= 500) {
        return left('Server error accured');
      } else {
        return left(response.reasonPhrase ?? 'Unknown error accured');
      }
    } catch (e) {
      return left('Unexpected errror accured');
    }
  }

  @override
  FutureEitherVoid register({required AccountModel account}) async {
    try {
      final url = Uri.parse('${DataConstants.baseUrl}/register');
      final headers = {'Content-Type': 'application/json'};
      final body = account.toJson();

      final response = await _client.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return right(null);
      } else if (response.statusCode == 401) {
        return left(
          'Account for provided creditials already exist. Use them to login',
        );
      } else if (response.statusCode >= 500) {
        return left('Server error accured');
      } else {
        return left(
          response.reasonPhrase != null
              ? (response.reasonPhrase!.isNotEmpty
                  ? response.reasonPhrase!
                  : 'Unknown error accured')
              : 'Unknown error accured',
        );
      }
    } catch (e) {
      return left('Unexpected errror accured');
    }
  }
}
