import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorGameWidget extends StatelessWidget {
  const ErrorGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'error'.tr(),
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}