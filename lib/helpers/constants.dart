



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

const String localBaseURL = "https://lol-api-dev.herokuapp.com/graphql";
// const String indicatif = "+212";
// const String indicatif = "+221";
const String indicatif = "+245";

const kPrimaryColor =  Color(0xff35a687);
const kBtnColor =  Color(0xffc4b270);
const kWarningColor =  Color(0xFFFF8A01);
const kPrimaryLightColor = Color(0xFFB1D9F9);
const kBackgroundColor = Color(0xFFF9F8FD);
const kTextColor = Color(0xFF4F4F4F);

const double kDefaultPadding = 20.0;
const double kDefaultFontSize = 12.0;
const double kDefaultTitleFontSize = 16.0;

String numeroValidate(value) {
  if (value.isEmpty) {
    return 'invalidNumber'.tr();
  } else if(validate(value).isNumeric && !validate(value).isValidPhone){
    return 'invalidNumber'.tr();
  }
  return 'ok'.tr();
}

extension validate on String {
  bool get isValidEmail {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'(^[0-9]{8,9}$)').hasMatch(this);
  }

  bool get isValidPassword {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(this);
  }

  bool get isNumeric {
    if (this == null) {
      return false;
    }
    return int.tryParse(this) != null;
  }

  bool get notExpired {
    final jwt = Jwt.parseJwt(this);
    // jwt.
    return false;
  }
}

void displaySnackBar(String message, BuildContext buildContext) {

  final scaffoldMessenger = ScaffoldMessenger.of(
    // scaffoldKey.currentContext!,
    buildContext,
  );

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.airline_stops, color: Colors.white),
          const SizedBox(width: 10),
          Flexible(child: Text(message)),
        ],
      ),
    ),
  );
}