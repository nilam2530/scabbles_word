import 'package:scabbles_word/src/routing/not_found_screen.dart';
import 'package:scabbles_word/src/routing/route_names.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/ui/main_layout.dart';
import 'package:go_router/go_router.dart';

import '../screen/splash/splash_screen.dart';

class AppRouter {
  late final GoRouter goRouter;

  AppRouter() {
    goRouter = GoRouter(
      initialLocation: AppRoute.splash.getPath,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.getPath,
          name: AppRoute.splash.getName,
          builder: (context, state) =>
              GameGifSplash(),
        ),
        GoRoute(
          path: AppRoute.mainScreen.getPath,
          name: AppRoute.mainScreen.getName,
          builder: (context, state) =>
              MainLayout(),

        ),
        // ShellRoute(
        //   builder: (context, state, child) {
        //     return ShellLayout(child: child); // Your shell layout widget
        //   },
        //   routes: [
        //     GoRoute(
        //       path: '/mainScreen',
        //       builder: (context, state) => const Dashboard(),
        //     ),
        //   ],
        // ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
