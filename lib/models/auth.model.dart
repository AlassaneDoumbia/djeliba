
import 'package:jwt_decode/jwt_decode.dart';

class Auth {
  final String userId;
  final String firstname;
  final String lastname;
  final String? country;
  final String? city;
  final String? phone;
  final String? address;
  final String accessToken;
  final String? email;
  // final String[] fcmtokens;
  final String createdAt;


  const Auth({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.accessToken,
    // this.fcmtokens,
    this.country,
    this.city,
    this.address,
    this.email,
    required this.createdAt,
  });

  factory Auth.fromJson(Map<String, dynamic> data) {
    final jwt = Jwt.parseJwt(data["access_token"]);
    print('jwt ::::: $jwt');
    print('jwt ::::: ${data["access_token"]}');
    final user = data["user"];
    print('user ::::: $user');
    return Auth(
      userId: user["_id"],
      phone: user["phone"],
      firstname: user["firstname"],
      lastname: user["lastname"],
      city: user["city"],
      accessToken: data["access_token"], createdAt: user["createdAt"],
      // fcmtokens: user["fcmtokens"],
    );
  }
}