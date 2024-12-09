import 'dart:convert';

class TransactionModel {
  final int? id;
  final String bank;
  final String accountName;
  final String accountNumber;
  final String beneficiaryReference;
  final String myReference;
  final double amount;
  final String? transferDate;
  TransactionModel({
    this.id,
    required this.bank,
    required this.accountName,
    required this.accountNumber,
    required this.beneficiaryReference,
    required this.myReference,
    required this.amount,
    this.transferDate,
  });

  TransactionModel copyWith({
    int? id,
    String? bank,
    String? accountName,
    String? accountNumber,
    String? beneficiaryReference,
    String? myReference,
    double? amount,
    String? transferDate,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      bank: bank ?? this.bank,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      beneficiaryReference: beneficiaryReference ?? this.beneficiaryReference,
      myReference: myReference ?? this.myReference,
      amount: amount ?? this.amount,
      transferDate: transferDate ?? this.transferDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bank': bank,
      'accountName': accountName,
      'accountNumber': accountNumber,
      'beneficiaryReference': beneficiaryReference,
      'myReference': myReference,
      'amount': amount
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as int?,
      bank: map['bank'] as String,
      accountName: map['accountName'] as String,
      accountNumber: map['accountNumber'] as String,
      beneficiaryReference: map['beneficiaryReference'] as String,
      myReference: map['myReference'] as String,
      amount: map['amount'] as double,
      transferDate: map['transferDate'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransferModel(id: $id, bank: $bank, accountName: $accountName, accountNumber: $accountNumber, beneficiaryReference: $beneficiaryReference, myReference: $myReference, amount: $amount, transferDate: $transferDate)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bank == bank &&
        other.accountName == accountName &&
        other.accountNumber == accountNumber &&
        other.beneficiaryReference == beneficiaryReference &&
        other.myReference == myReference &&
        other.amount == amount &&
        other.transferDate == transferDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bank.hashCode ^
        accountName.hashCode ^
        accountNumber.hashCode ^
        beneficiaryReference.hashCode ^
        myReference.hashCode ^
        amount.hashCode ^
        transferDate.hashCode;
  }
}
