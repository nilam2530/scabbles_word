import 'package:go_router/go_router.dart';
import 'package:scabbles_word/src/routing/route_config.dart';
import 'package:scabbles_word/src/screen/game/data/data_source/tile_data_source.dart';
import 'package:scabbles_word/src/screen/game/data/repo/tile_repo_impl.dart';
import 'package:scabbles_word/src/screen/game/domane/repo/tile_rack_repo.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/remove_tile_usecase.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/tile_rack_usecase.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/cubit/radom_tile_cubit.dart';
import 'package:scabbles_word/src/screen/game/presentation/widget/word_list.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<TileDataSource>(() => TileDataSourceImpl());
  getIt.registerLazySingleton<TileRepository>(
    () => TileRepoImpl(getIt<TileDataSource>()),
  );
  getIt.registerLazySingleton<TileRackUseCase>(
    () => TileRackUseCase(getIt<TileRepository>()),
  );
  getIt.registerLazySingleton<RemoveTileUsecase>(
    () => RemoveTileUsecase(getIt<TileRepository>()),
  );
  getIt.registerLazySingleton<TileRackCubit>(
    () => TileRackCubit(getIt<TileRackUseCase>(), getIt<RemoveTileUsecase>()),
  );
  getIt.registerSingleton<LettersCubit>(LettersCubit(letters));

  getIt.registerSingleton<AppRouter>(AppRouter());

  getIt.registerSingleton<GoRouter>(getIt<AppRouter>().goRouter);
}
