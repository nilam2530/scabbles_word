// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
//
// import 'http_interceptor.dart';
//
// class ApiService {
// //  final HttpInterceptor _httpInterceptor;
//
//   ApiService(this._httpInterceptor);
//
//   Future<http.Response> post(String url, Map<String, dynamic> body,
//       {Map<String, String>? headers}) async {
//     final request = http.Request('POST', Uri.parse(url));
//     request.body = json.encode(body);
//     request.headers['Content-Type'] = 'application/json';
//     if (headers != null) {
//       request.headers.addAll(headers);
//     }
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//     final streamedResponse = await interceptedRequest.send();
//     final interceptedResponse =
//         await _httpInterceptor.interceptResponse(streamedResponse);
//     return _handleResponse(interceptedResponse);
//   }
//
//   Future<http.Response> put(String url, Map<String, dynamic> body,
//       {Map<String, String>? headers}) async {
//     final request = http.Request('PUT', Uri.parse(url));
//     request.body = json.encode(body);
//     request.headers['Content-Type'] = 'application/json';
//     if (headers != null) {
//       request.headers.addAll(headers);
//     }
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//     final streamedResponse = await interceptedRequest.send();
//     final interceptedResponse =
//         await _httpInterceptor.interceptResponse(streamedResponse);
//     return _handleResponse(interceptedResponse);
//   }
//
//   Future<http.Response> get(String url, {Map<String, String>? headers}) async {
//     final request = http.Request('GET', Uri.parse(url));
//     if (headers != null) {
//       request.headers.addAll(headers);
//     }
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//     final streamedResponse = await interceptedRequest.send();
//     final interceptedResponse =
//         await _httpInterceptor.interceptResponse(streamedResponse);
//     return _handleResponse(interceptedResponse);
//   }
//
//   Future<http.Response> delete(String url,
//       {Map<String, String>? headers}) async {
//     final request = http.Request('DELETE', Uri.parse(url));
//     if (headers != null) {
//       request.headers.addAll(headers);
//     }
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//     final streamedResponse = await interceptedRequest.send();
//     final interceptedResponse =
//         await _httpInterceptor.interceptResponse(streamedResponse);
//     return _handleResponse(interceptedResponse);
//   }
//
//   Future<http.Response> multipartPut(
//       String url, Map<String, String> fields, File? file,
//       {Map<String, String>? headers}) async {
//     final uri = Uri.parse(url);
//     final request = http.MultipartRequest('PUT', uri);
//
//     fields.forEach((key, value) {
//       request.fields[key] = value;
//     });
//
//     if (file != null) {
//       var stream = http.ByteStream(file.openRead());
//       var length = await file.length();
//       var multipartFile = http.MultipartFile(
//         'file',
//         stream,
//         length,
//       );
//       request.files.add(multipartFile);
//     }
//
//     if (headers != null) {
//       request.headers.addAll(headers);
//     }
//
//     final interceptedRequest = await _httpInterceptor.interceptRequest(request);
//     final streamedResponse = await interceptedRequest.send();
//     final interceptedResponse =
//         await _httpInterceptor.interceptResponse(streamedResponse);
//     return _handleResponse(interceptedResponse);
//   }
//
//   Future<http.Response> _handleResponse(http.StreamedResponse response) async {
//     try {
//       final res = await http.Response.fromStream(response);
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         return res;
//       } else {
//         final responseBody = json.decode(res.body);
//         final errorMessage =
//             responseBody['apierror']['message'] ?? 'Unknown error';
//         throw ApiException(res.statusCode, errorMessage);
//       }
//     } on http.ClientException {
//       throw ApiException(-1, 'Client Exception');
//     } on TimeoutException {
//       throw ApiException(-1, 'Request Timeout');
//     } catch (e) {
//       throw ApiException(-1, e.toString());
//     }
//   }
// }
//
// class ApiException implements Exception {
//   final int statusCode;
//   final String message;
//
//   ApiException(this.statusCode, this.message);
//
//   @override
//   String toString() {
//     return message;
//   }
// }
