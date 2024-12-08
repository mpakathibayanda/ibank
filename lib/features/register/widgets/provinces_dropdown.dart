import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibank/core/customs/pallete.dart';
import 'package:ibank/features/register/controller/address_details_ctrl.dart';

class ProvincesDropdown extends ConsumerStatefulWidget {
  const ProvincesDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProvincesDropdownState();
}

class _ProvincesDropdownState extends ConsumerState<ProvincesDropdown> {
  // List of South African provinces
  final List<String> provinces = [
    'Eastern Cape',
    'Free State',
    'Gauteng',
    'KwaZulu-Natal',
    'Limpopo',
    'Mpumalanga',
    'Northern Cape',
    'North West',
    'Western Cape',
  ];

  @override
  Widget build(BuildContext context) {
    final provinceCtrl =
        ref.watch(addressDetailsStateCtrlProvider).provinceCtrl;
    return DropdownButtonFormField<String>(
      value: provinceCtrl.text.isNotEmpty ? provinceCtrl.text : null,
      validator: (value) {
        if (provinces.contains(provinceCtrl.text)) return null;
        return 'Select your province';
      },
      hint: const Text(
        'SELECT PROVINCE',
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
        ref
            .read(addressDetailsStateCtrlProvider.notifier)
            .setProvince(value ?? '');
      },
    );
  }
}
