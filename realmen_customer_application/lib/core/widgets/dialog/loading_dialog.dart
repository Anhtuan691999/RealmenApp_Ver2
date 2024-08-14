import 'package:flutter/material.dart';

typedef CloseDialog = void Function();
typedef ShowDialog = void Function();

CloseDialog closeLoadingDialog({required BuildContext context}) {
  return () => Navigator.of(context).pop();
}

ShowDialog showLoadingDialog({required BuildContext context}) {
  return () => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.black54,
            ),
          ));
}
