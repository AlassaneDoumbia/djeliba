
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlCustomProvider extends ChangeNotifier {

  final timeStr = '00:01:00.00';
  final String loginQuery = """
    query Login(\$loginInput: LoginInput!) {
      login(loginInput: \$loginInput) {
        user {
          _id,
          phone,
          firstname,
          country
        }
      }
    }
    """;

  authentification(code, phone, password){

    if (kDebugMode) {
      print("code ::::: $code");
      print("phone ::::: $phone");
      print("password ::::: $password");
    }
    final observableQuery =  useWatchQuery(WatchQueryOptions(
        document: gql(loginQuery),
        variables : const <String, dynamic>{
          "loginInput": {
            "calling_code": "+245",
            "password": "Djeliba#2024",
            "phone": "956300035"
          }
        },
    ));


    print(observableQuery);
  }
}