import 'package:flutter/material.dart';
import 'package:ibank/core/customs/pallete.dart';

extension BuildContextExt on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  void snackBar({required String msg, Color? color, Color? textColor}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Pallete.white,
          ),
        ),
        backgroundColor: color ?? Pallete.strongBlue,
      ),
    );
  }

  Future<bool> sureDialog({String? title, String? text}) async {
    final res = await showDialog<bool>(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? 'Are you Sure?',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Pallete.white,
            ),
          ),
          content: text != null
              ? Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Pallete.white,
                  ),
                )
              : null,
          backgroundColor: Pallete.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Pallete.strongBlue),
          ),
          actions: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
              child: const Text(
                'YES',
                style: TextStyle(color: Pallete.white),
              ),
            ),
            OutlinedButton(
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(false),
              child: const Text(
                'NO',
                style: TextStyle(color: Pallete.white),
              ),
            ),
          ],
        );
      },
    );
    return res ?? false;
  }
}
