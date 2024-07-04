

import 'package:djeliba/locator.dart';
import 'package:djeliba/models/auth.model.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'base.service.dart';

class AuthService extends ChangeNotifier {
  Auth? _auth;
  final client = locator<BaseService>().client;
  final storageService = locator<SecureStorageService>();
  final String loginQuery = """
    query Login(\$loginInput: LoginInput!) {
      login(loginInput: \$loginInput) {
        access_token,
        user {
          _id,
          phone,
          firstname,
          country,
          city,
          address,
          lastname,
          email,
          createdAt,
          fcmtokens
        }
      }
    }
    """;
  Auth? get auth => _auth;

  Future<void> initAuthIfPreviouslyLoggedIn() async {
    final auth = await storageService.getAuthData();
    if (auth.hasTokens) {
      // _auth = Auth.fromAuthData(auth);
      notifyListeners();
    }
  }

  Future<void> login(calling_code, phone, password) async {
    final result = await client.query(
        QueryOptions(
          document: gql(loginQuery),
          variables : <String, dynamic>{
            "loginInput": {
              "calling_code": calling_code,
              "password": password,
              "phone": phone
            }
          },
        )
    );
    print("result ${_auth}");
    print("result $result");
    print("result ${result.data}");

    if(result.data == null){
      throw gqlErrorHandler(result.exception);
    }
    print("result ${result.data?['login']}");
    final resp = result.data?['login'];
    // final resp = Auth.fromJson(data);

    _auth = Auth.fromJson(resp);
    print("result ${_auth}");

    if (_auth is Auth) {
      // _auth = Auth.fromJson(resp);
      storageService.storeAuthData(_auth!);
      notifyListeners();
    } else {
      throw gqlErrorHandler(result.exception);
    }
  }



  Future<void> logout() async {
    await locator<SecureStorageService>().clearAuthData();
    _auth = null;
    notifyListeners();
  }

  // You can put this in a common utility functions so
  // that you can reuse it in other services file too.
  //
  String gqlErrorHandler(OperationException? exception) {
    if (exception != null && exception.graphqlErrors.isNotEmpty) {
      return exception.graphqlErrors.first.message;
    }
    return "Something went wrong.";
  }
}