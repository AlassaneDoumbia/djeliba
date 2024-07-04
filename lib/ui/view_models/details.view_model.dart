


import 'package:djeliba/locator.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/services/deliver.service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'base.vm.dart';

class DetailsViewModel extends BaseViewModel {
  Delivery? _delivery;
  String? _id;
  bool? _valueCheck ;
  bool _loading = false ;
  String? _password;
  String _code = "+245";
  bool? _rememberMe;

  // Used for validation or any other purpose like clearing form and more...
  // final formKey = GlobalKey<FormState>();

  final _deliverService = locator<DeliverService>();

  Delivery get delivery => _delivery!;
  String get id => _id!;
  bool get loading => _loading;

  void onChangedDelivery(Delivery value) => _delivery = value;

  void onChangedPassword(String value) => _password = value;

  void onChangedvalueCheck(bool value) => _valueCheck = value;

  void onChangedLoading(bool value) => _loading = value;

  void onChangedRememberMe(bool value) => _rememberMe = value;

  void onChangedID(String value) => _id = value;

  void onChangedCode(String value) => _code = value;

  Future<Delivery> info(BuildContext context, String id) async {
    onChangedLoading(true);
    print("info delivery ::::::::: ");

    try{
      Delivery result = await _deliverService.info(id);
      print("info result ::::::::: $result");
      onChangedDelivery(result);
    }catch(error){
      print("error ::::::::: $error");
      displaySnackBar(tr('errorLogin'), context);
    }finally{
      onChangedLoading(false);
    }
    return delivery;
  }

  // Future<void> onLogin(BuildContext context) async {
  //   // Validate login details using [formKey]
  //   // if (!formKey.currentState!.validate()) return;
  //
  //   String res = "OK";
  //   try {
  //     setIsLoading(true);
  //     // final input = Input$LoginInput(identifier: _phone!, password: _password!);
  //     await _authService.login(_code, _phone, _password);
  //   } catch (error) {
  //     print("error ::::::::: $error");
  //     res = "NOK";
  //     displaySnackBar(tr('errorLogin'), context);
  //   } finally {
  //     setIsLoading(false);
  //     print(res);
  //     if(res == "OK"){
  //       context.go('/home');
  //     }
  //   }
  // }
}