enum AppRoute {
  splash,
  mainScreen,
}

extension AppRouteExt on AppRoute {
  String get getPath {
    switch (this) {
      case AppRoute.splash:
        return '/';

      case AppRoute.mainScreen:
        return '/mainScreen';
      default:
        return '/splash';
    }
  }

  String get getName {
    switch (this) {
      case AppRoute.splash:
        return 'splash';
      case AppRoute.mainScreen:
        return 'mainScreen';
      default:
        return 'login';
    }
  }
}
