// import 'dart:convert';
//
// /
// class TokenService {
//  // final FlutterSecureStorage _storage = const FlutterSecureStorage();
//
//   Future<Map<String, String>> getAuthorizationHeaderOnly() async {
//     final token = await getAccessToken();
//     if (token == null) {
//       return {};
//     }
//     return {'Authorization': 'Bearer $token'};
//   }
//
//   Future<String?> getUserNameFromStorage() async {
//     return await _storage.read(key: 'username');
//   }
//
//   Future<void> writeUserNameToStorage(String username) async {
//     await _storage.write(key: 'username', value: username);
//   }
//
//   Future<String?> getPasswordFromStorage() async {
//     return await _storage.read(key: 'password');
//   }
//
//   Future<void> writePasswordToStorage(String password) async {
//     await _storage.write(key: 'password', value: password);
//   }
//
//   Future<void> deleteCredentials() async {
//     await _storage.delete(key: 'username');
//     await _storage.delete(key: 'password');
//   }
//
//   Future<bool> getRememberMeFromStorage() async {
//     final rememberMe = await _storage.read(key: 'rememberMe');
//     return rememberMe == 'true';
//   }
//
//   Future<void> saveRememberMeToStorage(bool rememberMe) async {
//     await _storage.write(key: 'rememberMe', value: rememberMe.toString());
//   }
//
//   Future<String?> getAccessToken() async {
//     return await _storage.read(key: 'accessToken');
//   }
//
//   Future<String?> getRefreshToken() async {
//     return await _storage.read(key: 'refreshToken');
//   }
//
//   Future<void> saveAccessToken(String token) async {
//     await _storage.write(key: 'accessToken', value: token);
//   }
//
//   Future<void> saveRefreshToken(String token) async {
//     await _storage.write(key: 'refreshToken', value: token);
//   }
//
//   Future<void> deleteTokens() async {
//     await _storage.delete(key: 'accessToken');
//     await _storage.delete(key: 'refreshToken');
//   }
//
//   bool isTokenExpired(String token) {
//     final List<String> parts = token.split('.');
//     if (parts.length != 3) {
//       return true;
//     }
//
//     final String payload =
//         utf8.decode(base64.decode(base64.normalize(parts[1])));
//     final Map<String, dynamic> payloadMap = json.decode(payload);
//
//     final int exp = payloadMap['exp'];
//     final DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
//     return DateTime.now().isAfter(expiryDate);
//   }
// }
