

import 'package:djeliba/locator.dart';
import 'package:djeliba/models/auth.model.dart';
import 'package:djeliba/models/delivery.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'base.service.dart';

class DeliverService extends ChangeNotifier {
  Delivery? _delivery;
  final client = locator<BaseService>().client;
  final storageService = locator<SecureStorageService>();

  final String infoQuery = """
    query Delivery(\$deliveryId: ID!) {
      delivery(id: \$deliveryId) {
        _id,
        addressA,
        addressB,
        deliveryAmount,
        description,
        locationA,
        locationB,
        nameA,
        nameB,
        state,
        status,
        createdAt
      }
    }
    """;
  final String listQuery = """
    query Delivery(\$deliveryId: ID!) {
      delivery(id: \$deliveryId) {
        _id,
        addressA,
        addressB,
        deliveryAmount,
        description,
        locationA,
        locationB,
        nameA,
        nameB,
        state,
        status,
        createdAt
      }
    }
    """;


  Delivery? get delivery => _delivery;

  Future<void> initAuthIfPreviouslyLoggedIn() async {
    final auth = await storageService.getAuthData();
    if (auth.hasTokens) {
      // _auth = Auth.fromAuthData(auth);
      notifyListeners();
    }
  }

  Future<Delivery> info(id) async {
    final result = await client.query(
        QueryOptions(
          document: gql(infoQuery),
          variables : <String, dynamic>{
            "deliveryId": "$id"
          },
        )
    );

    print("result $result");
    print("result ${result.data}");

    if(result.data == null){
      throw gqlErrorHandler(result.exception);
    }
    print("result ${result.data?['delivery']}");
    final resp = result.data?['delivery'];
    _delivery = Delivery.fromJson(resp);

    print("result $_delivery");

    if (_delivery is Delivery) {
      notifyListeners();
    } else {
      throw gqlErrorHandler(result.exception);
    }
    return delivery!;
  }



  Future<void> logout() async {
    await locator<SecureStorageService>().clearAuthData();
    _delivery = null;
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