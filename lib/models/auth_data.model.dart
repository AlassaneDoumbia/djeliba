
class AuthData {
  final String? accessToken;
  final String? id;
  final String? phone;
  final String? fullName;
  final String? lastName;

  const AuthData({
    required this.accessToken,
    required this.id,
    required this.phone,
    required this.fullName,
    required this.lastName,
  });

  bool get hasTokens => accessToken != null ? true : false;
}