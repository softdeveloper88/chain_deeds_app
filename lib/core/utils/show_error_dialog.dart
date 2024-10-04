import 'package:chain_deeds_app/screens/authenatication_screens/error_dialog/error_dialog.dart';
import 'package:flutter/material.dart';

void showErrorDialog(Map<String, dynamic> errors,context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ErrorDialog(errors: errors);
    },
  );
}