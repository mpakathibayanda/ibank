// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/models/login_details.dart';

import 'package:ibank/core/models/transaction_model.dart';
import 'package:ibank/data/transaction/usecases/transfer_usecase.dart';
import 'package:ibank/features/login/controller/account_ctrl.dart';

final transferStateCtrlProvider =
    StateNotifierProvider.autoDispose<TransferStateCtrl, TransferState>(
  (ref) {
    final transferUsecase = ref.watch(transferUsecaseProvider);
    return TransferStateCtrl(ref, transferUsecase: transferUsecase);
  },
);

class TransferStateCtrl extends StateNotifier<TransferState> {
  final TransferUsecase _transferUsecase;
  final Ref _ref;
  TransferStateCtrl(Ref ref, {required TransferUsecase transferUsecase})
      : _transferUsecase = transferUsecase,
        _ref = ref,
        super(
          TransferState(
            formKey: GlobalKey<FormState>(),
            bankCtrl: TextEditingController(),
            accountNameCtrl: TextEditingController(),
            accountNumberCtrl: TextEditingController(),
            beneficiaryReferenceCtrl: TextEditingController(),
            amountCtrl: TextEditingController(),
            isTransfering: false,
            error: '',
          ),
        );

  Future<bool> transfer(LoginParams loginParams) async {
    try {
      if (!state.formKey.currentState!.validate()) {
        return false;
      }
      state = state.copyWith(isTransfering: true, error: '');
      final transaction = TransactionModel.fromMap(details);
      final account = _ref.read(accountStateCtrlProvider).account!;
      final loginParams = LoginParams(
        username: account.email,
        password: account.password,
      );
      final transferUsecaseParams = TransferUsecaseParams(
        loginParams: loginParams,
        transaction: transaction,
      );
      return await _transferUsecase(transferUsecaseParams).then(
        (res) {
          return res.fold(
            (error) {
              state = state.copyWith(
                isTransfering: false,
                error: error.isNotEmpty ? error : 'Unknown error',
              );
              return false;
            },
            (transaction) {
              state = state.copyWith(
                transaction: transaction,
                error: null,
                isTransfering: false,
              );
              _ref
                  .read(accountStateCtrlProvider.notifier)
                  .setAmount(-transaction.amount);
              return true;
            },
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isTransfering: false,
        error: e.toString().isNotEmpty ? e.toString() : 'Unknown error accured',
      );
      return false;
    }
  }

  void setBank(String bank) {
    state = state.copyWith(
      bankCtrl: TextEditingController(text: bank),
    );
  }

  void setError(String? value) {
    state = state.copyWith(error: value ?? '');
  }

  Map<String, dynamic> get details => {
        'bank': state.bankCtrl.text,
        'accountName': state.accountNameCtrl.text,
        'accountNumber': state.accountNumberCtrl.text,
        'beneficiaryReference': state.beneficiaryReferenceCtrl.text,
        'myReference':
            _ref.read(accountStateCtrlProvider).account?.accountNumber,
        'amount': double.parse(state.amountCtrl.text),
      };

  @override
  void dispose() {
    state.bankCtrl.dispose();
    state.accountNameCtrl.dispose();
    state.accountNumberCtrl.dispose();
    state.beneficiaryReferenceCtrl.dispose();
    state.amountCtrl.dispose();
    state.formKey.currentState?.reset();
    super.dispose();
  }
}

class TransferState {
  final TransactionModel? transaction;
  final GlobalKey<FormState> formKey;
  final TextEditingController bankCtrl;
  final TextEditingController accountNameCtrl;
  final TextEditingController accountNumberCtrl;
  final TextEditingController beneficiaryReferenceCtrl;
  final TextEditingController amountCtrl;
  final bool isTransfering;
  final String error;

  TransferState({
    this.transaction,
    required this.formKey,
    required this.bankCtrl,
    required this.accountNameCtrl,
    required this.accountNumberCtrl,
    required this.beneficiaryReferenceCtrl,
    required this.amountCtrl,
    required this.isTransfering,
    required this.error,
  });

  TransferState copyWith({
    TransactionModel? transaction,
    GlobalKey<FormState>? formKey,
    TextEditingController? bankCtrl,
    TextEditingController? accountNameCtrl,
    TextEditingController? accountNumberCtrl,
    TextEditingController? beneficiaryReferenceCtrl,
    TextEditingController? amountCtrl,
    bool? isTransfering,
    String? error,
  }) {
    return TransferState(
      transaction: transaction ?? this.transaction,
      formKey: formKey ?? this.formKey,
      bankCtrl: bankCtrl ?? this.bankCtrl,
      accountNameCtrl: accountNameCtrl ?? this.accountNameCtrl,
      accountNumberCtrl: accountNumberCtrl ?? this.accountNumberCtrl,
      beneficiaryReferenceCtrl:
          beneficiaryReferenceCtrl ?? this.beneficiaryReferenceCtrl,
      amountCtrl: amountCtrl ?? this.amountCtrl,
      isTransfering: isTransfering ?? this.isTransfering,
      error: error ?? this.error,
    );
  }
}
