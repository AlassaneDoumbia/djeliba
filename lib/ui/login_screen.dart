import 'package:djeliba/ui/base.view.dart';
import 'package:djeliba/ui/home.dart';
import 'package:djeliba/helpers/constants.dart';
import 'package:djeliba/ui/view_models/login.view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/graphqlProvider.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  final bool isChecked = false;
  // final String username = '';
  // final String password = '';
  final String indicatif = "+245";
  // final String numero;
  // final bool statusBtn = false ;
  final BorderSide borderSide = const BorderSide(color: Colors.black12);


  updateBntState(value){
    print("calling updateBntState");
    // setState(() {
    //   numero = value;
    // });
    // print(numero);
    // if(validate(numero!).isValidPhone && numero!.length == 9) {
    //   setState(() {
    //     statusBtn = true;
    //   });
    // }

  }

  bool localAuth({
    required String login,
    required String password,
  }) {
    if (login == 'admin' && password == '123456') {
      return true;
    } else {
      return false;
    }
  }

  onLogin() async {
    // var res = true;
    // var res = localAuth(password: password, login: username);
    // var res = authMethod("", password, username);
    // if (res) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setBool('saveUser', isChecked);
    //   // context.go('/home');
    //
    // }
  }

  void _onCountryChange(CountryCode countryCode, LoginViewModel loginModel) {
    //TODO : manipulate the selected country code here
    if (kDebugMode) {
      print("New Country selected: $countryCode");
    }


  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;

    return BaseView<LoginViewModel>(
        builder: (context, loginVm, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(height: heightSize *0.1),
                  Container(
                    width: double.infinity,
                    height: heightSize / 4,
                    child: Image.asset('assets/images/logo_dark.png'),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'welcomeMsg'.tr(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // TextFormField(
                              //   keyboardType: TextInputType.number,
                              //   maxLength: 9,
                              //   // validator: (value) => numeroValidate(value),
                              //   // onSaved: (value) =>updateBntState(value),
                              //   onChanged: (text) => updateBntState(text),
                              //   style: TextStyle(
                              //     fontSize: heightSize * 0.021,
                              //     fontWeight: FontWeight.bold,
                              //
                              //   ),
                              //   decoration: InputDecoration(
                              //     enabledBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.black12),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderSide: BorderSide(color: Colors.black12),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     prefixIcon: Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 0),
                              //       child: CountryCodePicker(
                              //         onChanged: _onCountryChange,
                              //         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              //         initialSelection: indicatif,
                              //         favorite: const ['+245', '+221'],
                              //         // countryFilter: ['+245', '+221'],
                              //         // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                              //         // flagDecoration: BoxDecoration(
                              //         //   borderRadius: BorderRadius.circular(7),
                              //         // ),
                              //       ),
                              //     ),
                              //
                              //   ),
                              // ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kBackgroundColor,
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: heightSize * 0.021,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // onChanged: (value) {
                                  //   username = value;
                                  // },
                                  keyboardType: TextInputType.phone,
                                  onChanged: loginVm.onChangedPhoneNum,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: borderSide,
                                        borderRadius: BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: borderSide,
                                        borderRadius: BorderRadius.circular(10)),
                                    // border: const OutlineInputBorder(
                                    //   borderSide: BorderSide(color: kBackgroundColor)
                                    // ),
                                    hintText: 'username'.tr(),
                                    hintStyle: const TextStyle(color: kTextColor),
                                    prefixIcon: CountryCodePicker(
                                      onChanged: (value) => loginVm.onChangedCode(value.toString()),
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: indicatif,
                                      favorite: const ['+245', '+221'],
                                      // countryFilter: ['+245', '+221'],
                                      // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                                      // flagDecoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(7),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kBackgroundColor,
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: heightSize * 0.021,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // onChanged: (value) {
                                  //   password = value;
                                  // },

                                  obscureText: true,
                                  onChanged: loginVm.onChangedPassword,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: borderSide,
                                        borderRadius: BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: borderSide,
                                        borderRadius: BorderRadius.circular(10)),
                                    // border: const OutlineInputBorder(
                                    //   borderSide: BorderSide(color: kBackgroundColor)
                                    // ),
                                    hintText: 'password'.tr(),
                                    hintStyle: const TextStyle(color: kTextColor),
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[

                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: isChecked,
                                      onChanged: (bool? value) {

                                        loginVm.onChangedRememberMe(value!);
                                      },
                                    ),
                                    Text(
                                      'rememberMe'.tr(),
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                  ]
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap:  () => loginVm.onLogin(context),
                                // onTap: () => onLogin(),
                                // onTap: () {
                                //   Navigator.push(context,
                                //       MaterialPageRoute(
                                //           builder: (context) => HomeScreen()));
                                // },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      child:  loginVm.isLoading ? const CircularProgressIndicator(color: Colors.white,) : Text(
                                        'connect'.tr(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Query(
                              //   options: QueryOptions(
                              //     document: gql(loginQuery), // this is the query string you just created
                              //     variables : const <String, dynamic>{"loginInput": {
                              //         "calling_code": "+245",
                              //         "password": "Djeliba#2024",
                              //         "phone": "956300035"
                              //       }
                              //     },
                              //     pollInterval: const Duration(seconds: 10),
                              //   ),
                              //   // Just like in apollo refetch() could be used to manually trigger a refetch
                              //   // while fetchMore() can be used for pagination purpose
                              //   builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                              //     if (result.hasException) {
                              //       return Text(result.exception.toString());
                              //     }
                              //
                              //     if (result.isLoading) {
                              //       return const Text('Loading');
                              //     }
                              //     print(result.data);
                              //     List? repositories = result.data?['viewer']?['repositories']?['nodes'];
                              //
                              //     if (repositories == null) {
                              //       return const Text('No repositories');
                              //     }
                              //
                              //     return ListView.builder(
                              //         itemCount: repositories.length,
                              //         itemBuilder: (context, index) {
                              //           final repository = repositories[index];
                              //
                              //           return Text(repository['name'] ?? '');
                              //         });
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );


  }
}