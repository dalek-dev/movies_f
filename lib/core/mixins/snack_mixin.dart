import 'package:flutter/material.dart';

mixin SnacksMixin {
  final Duration _defaultDuration = const Duration(milliseconds: 4000);

  void showErrorSnack(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline_sharp,
              color: Colors.white,
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: _defaultDuration,
        elevation: 0.0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }
}
