import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

class CustomTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Color fillColor;
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.enabled = true,
    required this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.fillColor = Pallete.white,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = true;
  void _showHidePassword() => setState(() => _showPassword = !_showPassword);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      cursorColor: Colors.black,
      obscureText: widget.isPassword ? _showPassword : false,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: Pallete.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey),
        errorStyle: const TextStyle(color: Colors.red),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        fillColor: widget.fillColor,
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: _showHidePassword,
                icon: Icon(
                  _showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
