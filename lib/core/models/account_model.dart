import 'dart:convert';

class AccountModel {
  final String? accountNumber;
  final String firstName;
  final String lastName;
  final String cellNumber;
  final String email;
  final String province;
  final String suburb;
  final String city;
  final String streetNumber;
  final String streetName;
  final String idNumber;
  final String password;
  final String? dateOfBirth;
  final double balance;
  AccountModel({
    this.accountNumber,
    required this.firstName,
    required this.lastName,
    required this.cellNumber,
    required this.email,
    required this.province,
    required this.suburb,
    required this.city,
    required this.streetNumber,
    required this.streetName,
    required this.idNumber,
    required this.password,
    this.dateOfBirth,
    required this.balance,
  });

  AccountModel copyWith({
    String? accountNumber,
    String? firstName,
    String? lastName,
    String? cellNumber,
    String? email,
    String? province,
    String? suburb,
    String? city,
    String? streetNumber,
    String? streetName,
    String? idNumber,
    String? password,
    String? dateOfBirth,
    double? balance,
  }) {
    return AccountModel(
      accountNumber: accountNumber ?? this.accountNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      cellNumber: cellNumber ?? this.cellNumber,
      email: email ?? this.email,
      province: province ?? this.province,
      suburb: suburb ?? this.suburb,
      city: city ?? this.city,
      streetNumber: streetNumber ?? this.streetNumber,
      streetName: streetName ?? this.streetName,
      idNumber: idNumber ?? this.idNumber,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountNumber': accountNumber,
      'firstName': firstName,
      'lastName': lastName,
      'cellNumber': cellNumber,
      'email': email,
      'province': province,
      'suburb': suburb,
      'city': city,
      'streetNumber': streetNumber,
      'streetName': streetName,
      'idNumber': idNumber,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'balance': balance,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountNumber: map['accountNumber'] as String?,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      cellNumber: map['cellNumber'] as String,
      email: map['email'] as String,
      province: map['province'] as String,
      suburb: map['suburb'] as String,
      city: map['city'] as String,
      streetNumber: map['streetNumber'] as String,
      streetName: map['streetName'] as String,
      idNumber: map['idNumber'] as String,
      password: map['password'] as String,
      dateOfBirth: map['dateOfBirth'] as String?,
      balance: map['balance'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) =>
      AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountEntity(accountNumber: $accountNumber, firstName: $firstName, lastName: $lastName, cellNumber: $cellNumber, email: $email, province: $province, suburb: $suburb, city: $city, streetNumber: $streetNumber, streetName: $streetName, idNumber: $idNumber, password: $password, dateOfBirth: $dateOfBirth, balance: $balance)';
  }

  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;

    return other.accountNumber == accountNumber &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.cellNumber == cellNumber &&
        other.email == email &&
        other.province == province &&
        other.suburb == suburb &&
        other.city == city &&
        other.streetNumber == streetNumber &&
        other.streetName == streetName &&
        other.idNumber == idNumber &&
        other.password == password &&
        other.dateOfBirth == dateOfBirth &&
        other.balance == balance;
  }

  @override
  int get hashCode {
    return accountNumber.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        cellNumber.hashCode ^
        email.hashCode ^
        province.hashCode ^
        suburb.hashCode ^
        city.hashCode ^
        streetNumber.hashCode ^
        streetName.hashCode ^
        idNumber.hashCode ^
        password.hashCode ^
        dateOfBirth.hashCode ^
        balance.hashCode;
  }
}
