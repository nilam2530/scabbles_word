import 'package:scabbles_word/src/routing/route_config.dart';
import 'package:scabbles_word/src/services/api_service.dart';
import 'package:scabbles_word/src/services/http_interceptor.dart';
import 'package:scabbles_word/src/services/logger.dart';
import 'package:scabbles_word/src/services/token_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register the HttpInterceptor and ApiService
  //getIt.registerSingleton<HttpInterceptor>(HttpInterceptor());
  //getIt.registerSingleton<ApiService>(ApiService(getIt<HttpInterceptor>()));
  //getIt.registerSingleton<TokenService>(TokenService());
 // getIt.registerSingleton<AppRouter>(AppRouter());
//  getIt.registerSingleton<AppLogger>(AppLogger());
  }
