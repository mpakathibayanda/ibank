import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/features/transfer/controller/transfer_state_ctrl.dart';

class BanksDropdown extends ConsumerStatefulWidget {
  const BanksDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BanksDropdownState();
}

class _BanksDropdownState extends ConsumerState<BanksDropdown> {
  // List of banks
  final List<String> provinces = [
    'FNB',
    'Standard bank',
    'ABSA',
    'Nedbank',
    'Capitec'
  ];

  @override
  Widget build(BuildContext context) {
    final bankCtrl = ref.watch(transferStateCtrlProvider).bankCtrl;
    return DropdownButtonFormField<String>(
      value: bankCtrl.text.isNotEmpty ? bankCtrl.text : null,
      validator: (value) {
        if (provinces.contains(bankCtrl.text)) return null;
        return 'Select your bank';
      },
      hint: const Text(
        'SELECT BANK',
        style: TextStyle(
          color: Pallete.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: const TextStyle(
        color: Pallete.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Pallete.primary,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        fillColor: Pallete.white,
        filled: true,
      ),
      items: provinces.map((province) {
        return DropdownMenuItem(
          value: province,
          child: Text(province),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(transferStateCtrlProvider.notifier).setBank(value ?? '');
      },
    );
  }
}
