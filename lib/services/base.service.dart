
import 'dart:async';

import 'package:djeliba/locator.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class BaseService {
  late GraphQLClient _client;
  late ValueNotifier<GraphQLClient> _clientNotifier;

  bool _renewingToken = false;

  GraphQLClient get client => _client;

  ValueNotifier<GraphQLClient> get clientNotifier => _clientNotifier;

  BaseService() {
    final authLink = AuthLink(getToken: _getToken);
    final httpLink = HttpLink("https://lol-api-dev.herokuapp.com/graphql");

    /// The order of the links in the array matters!
    final link = Link.from([authLink, httpLink]);

    _client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      //
      // You have two other caching options.
      // But for my example I won't be using caching.
      //
      // cache: GraphQLCache(store: HiveStore()),
      // cache: GraphQLCache(store: InMemoryStore()),
      //
      defaultPolicies: DefaultPolicies(query: Policies(fetch: FetchPolicy.networkOnly)),
    );

    _clientNotifier = ValueNotifier(_client);
  }

  Future<String?> _getToken() async {
    if (_renewingToken) return null;

    final storageService = locator<SecureStorageService>();

    final authData = await storageService.getAuthData();
    print("authData Phone ${authData.phone}");
    print("authData fullName ${authData..fullName}");
    print("authData id ${authData.id}");
    print("authData accessToken ${authData.accessToken}");

    final aT = authData.accessToken;
    // final rT = authData.refreshToken;
    print("_getToken $aT");
    if (aT == null) return null;

    // if (Jwt.isExpired(aT)) {
    //   final renewedToken = await _renewToken(rT);
    //
    //   if (renewedToken == null) return null;
    //
    //   await storageService.updateAccessToken(renewedToken);
    //
    //   return 'Bearer $renewedToken';
    // }

    return 'Bearer $aT';
  }

  // Future<String?> _renewToken(String refreshToken) async {
  //
  //   try {
  //     _renewingToken = true;
  //
  //     final result = await _client.query$RenewAccessToken(Options$Query$RenewAccessToken(
  //       fetchPolicy: FetchPolicy.networkOnly,
  //       variables: Variables$Query$RenewAccessToken(
  //         input: Input$RenewTokenInput(refreshToken: refreshToken),
  //       ),
  //     ));
  //
  //     final resp = result.parsedData?.auth.renewToken;
  //
  //     if (resp is Fragment$RenewTokenSuccess) {
  //       return resp.newAccessToken;
  //     } else {
  //       if (result.exception != null && result.exception!.graphqlErrors.isNotEmpty) {
  //         locator<AuthService>().logout();
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     _renewingToken = false;
  //   }
  //
  //   return null;
  // }
}