import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:scabbles_word/src/routing/route_config.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/board_usecase.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_event.dart';
import 'package:scabbles_word/src/services/injection_container.dart';
import 'package:scabbles_word/src/themes/theme_provider.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_bloc.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/cubit/radom_tile_cubit.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final routes = getIt<GoRouter>();
    final routes = GetIt.I<GoRouter>();


    var size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        BlocProvider(
          create: (_) => BoardBloc(placeTileUseCase: PlaceTileUseCase())..add(LoadBoard()),
        ),
        BlocProvider<TileRackCubit>(
          create: (context) => getIt<TileRackCubit>()..onGenerateRandomTile(),
        ),
        BlocProvider<LettersCubit>(create: (_) => getIt<LettersCubit>()),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ScreenUtilInit(
            designSize: Size(size.width, size.height),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp.router(
              routerConfig: routes,
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'app',
              onGenerateTitle: (BuildContext context) => 'My Pro',
              themeMode: themeProvider.themeMode,
              darkTheme: ThemeData(brightness: Brightness.dark),
              theme: ThemeData(
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.black,
                  primary: Colors.black,
                ),
                useMaterial3: true,
                textTheme: TextTheme(
                  bodySmall: TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              supportedLocales: const [
                Locale('en', ''),
                Locale('hi', ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
