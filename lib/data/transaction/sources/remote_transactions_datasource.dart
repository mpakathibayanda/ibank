import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:ibank/core/models/login_details.dart';
import 'package:ibank/core/models/transaction_model.dart';
import 'package:ibank/core/types/future_either.dart';
import 'package:ibank/data/constants/data_constants.dart';
import 'package:ibank/data/transaction/repository/transactions_repo.dart';

class RemoteTransactionsDatasource implements TransactionsRepo {
  final http.Client _client;

  RemoteTransactionsDatasource({required http.Client client})
      : _client = client;
  @override
  FutureEither<List<TransactionModel>> getHistory({
    required LoginParams loginParams,
  }) async {
    try {
      final url = Uri.parse('${DataConstants.baseUrl}/transactions');
      final headers = _getHeaders(loginParams.username, loginParams.password);

      final response = await _client.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonRes = response.body;

        final Map<String, dynamic> transactionsData = jsonDecode(jsonRes);
        final received = transactionsData['receivedTransactions'] as List;
        final sent = transactionsData['sentTransactions'] as List;
        final asOnesData = [...received, ...sent];
        final transactions = asOnesData
            .map(
              (map) => TransactionModel.fromMap(map),
            )
            .toList();
        return right(transactions);
      } else if (response.statusCode == 401) {
        return left('Invalid creditials');
      } else if (response.statusCode >= 500) {
        return left('Server error accured');
      } else {
        return left(response.reasonPhrase ?? 'Unknown error accured');
      }
    } catch (e, _) {
      return left('Unexpected errror accured');
    }
  }

  @override
  FutureEither<TransactionModel> transfer({
    required LoginParams loginParams,
    required TransactionModel transaction,
  }) async {
    try {
      final url = Uri.parse('${DataConstants.baseUrl}/transfer');
      final headers = _getHeaders(loginParams.username, loginParams.password);
      final body = transaction.toJson();

      final response = await _client.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonRes = response.body;
        final transaction = TransactionModel.fromJson(jsonRes);
        return right(transaction);
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

  // Basic Auth Header
  Map<String, String> _getHeaders(String username, String password) {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };
  }
}
