


import 'package:djeliba/locator.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'base.vm.dart';

class LoginViewModel extends BaseViewModel {
  String? _phone;
  String? _password;
  String _code = "+245";
  bool? _rememberMe;

  // Used for validation or any other purpose like clearing form and more...
  // final formKey = GlobalKey<FormState>();

  final _authService = locator<AuthService>();

  void onChangedPassword(String value) => _password = value;

  void onChangedRememberMe(bool value) => _rememberMe = value;

  void onChangedPhoneNum(String value) => _phone = value;

  void onChangedCode(String value) => _code = value;

  Future<void> onLogin(BuildContext context) async {
    // Validate login details using [formKey]
    // if (!formKey.currentState!.validate()) return;

    String res = "OK";
    try {
      setIsLoading(true);
      // final input = Input$LoginInput(identifier: _phone!, password: _password!);
      await _authService.login(_code, _phone, _password);
    } catch (error) {
      print("error ::::::::: $error");
      res = "NOK";
      displaySnackBar(tr('errorLogin'), context);
    } finally {
      setIsLoading(false);
      print(res);
      if(res == "OK"){
        // context.go('/home');
        Navigator.of(context)
            .pushNamed('/home');
      }
      //
    }
  }
}