// import 'dart:convert';
//
// import 'package:scabbles_word/src/services/encryption.dart';
// import 'package:scabbles_word/src/services/logger.dart';
// import 'package:scabbles_word/src/services/service_locator.dart';
// import 'package:scabbles_word/src/services/token_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class HttpInterceptor {
//   Locale deviceLocale = PlatformDispatcher.instance.locale; // Updated
//
//   static final Map<String, String> _headers = {
//     'Content-Type': 'application/json',
//   };
//
//   Future<http.BaseRequest> interceptRequest(http.BaseRequest request) async {
//   // //  final tokenService = getIt<TokenService>();
//   //   final encryptionService = getIt<EncryptionService>();
//   //   final logger = getIt<AppLogger>();
//
//     String lang = deviceLocale.languageCode.toString();
//     _headers['lang'] = lang;
//     request.headers.addAll(_headers);
//
//   // //  final accessToken = await tokenService.getAccessToken();
//   //   if (accessToken != null) {
//   //     request.headers['Authorization'] = 'Bearer $accessToken';
//   //   }
//
//     if (request is http.Request && request.body.isNotEmpty) {
//       logger.logInfo('Original Request Body: ${request.body}');
//
//       final encryptedBody = encryptionService.encrypt(request.body);
//       request.body = jsonEncode({"data": encryptedBody});
//       if (kDebugMode) {
//         print('Encrypted Request Body: $encryptedBody');
//       }
//     }
//     _printInChunks('Request: ${request.method} ${request.url}');
//     _printInChunks('Headers: ${_formatJsonHeader(request.headers)}');
//
//     if (request is http.MultipartRequest) {
//       _logMultipartRequest(request);
//     }
//
//     return request;
//   }
//
//   Future<http.StreamedResponse> interceptResponse(
//       http.StreamedResponse response) async {
//     final encryptionService =
//         getIt<EncryptionService>(); // Get Encryption Service instance
//     final responseHeaders = response.headers;
//     final responseStatusCode = response.statusCode;
//     final responseBody = await response.stream.bytesToString();
//     if (kDebugMode) {
//       print('Encrypted Response Body: $responseBody');
//     }
//
//     String decryptedBody;
//     try {
//       final responseJson = jsonDecode(responseBody);
//       if (responseJson.containsKey('data')) {
//         decryptedBody = encryptionService
//             .decrypt(responseJson['data']); // Decrypt the "data" field
//         if (kDebugMode) {
//           print('Decrypted Response Body: ${_formatJson(decryptedBody)}');
//         }
//       } else {
//         decryptedBody = responseBody;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error decrypting response: $e');
//       }
//       decryptedBody = responseBody;
//     }
//
//     // Log response details
//     _printInChunks('Response Status: $responseStatusCode');
//     _printInChunks('Response Headers: ${_formatJsonHeader(responseHeaders)}');
//     _printInChunks('Response Body: ${_formatJson(decryptedBody)}');
//
//     // Recreate the StreamedResponse with decrypted body
//     return http.StreamedResponse(
//       Stream.value(utf8.encode(decryptedBody)),
//       responseStatusCode,
//       headers: responseHeaders,
//     );
//   }
//
//   // Log Multipart request details
//   void _logMultipartRequest(http.MultipartRequest request) {
//     _printInChunks(
//         'Multipart Request Fields: ${_formatJson(json.encode(request.fields))}');
//     for (var file in request.files) {
//       _printInChunks(
//           'Multipart Request File: ${file.filename} (${file.contentType})');
//     }
//   }
//
//   // Helper method to format JSON strings
//   String _formatJson(String jsonString) {
//     try {
//       final jsonObject = jsonDecode(jsonString);
//       return const JsonEncoder.withIndent('  ').convert(jsonObject);
//     } catch (e) {
//       return jsonString;
//     }
//   }
//
//   // Helper method to format headers as JSON
//   String _formatJsonHeader(Map<String, String> jsonMap) {
//     return const JsonEncoder.withIndent('  ').convert(jsonMap);
//   }
//
//   // Helper method to print logs in chunks
//   void _printInChunks(String text) {
//     const int chunkSize = 1000; // Define chunk size
//     for (int i = 0; i < text.length; i += chunkSize) {
//       if (kDebugMode) {
//         print(text.substring(
//             i, i + chunkSize < text.length ? i + chunkSize : text.length));
//       }
//     }
//   }
// }
