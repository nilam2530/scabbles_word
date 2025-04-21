import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/remove_tile_usecase.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/tile_rack_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../../utils/cubit/letters_cubit.dart';

part 'radom_tile_state.dart';

class TileRackCubit extends Cubit<TileRackState> {
  final TileRackUseCase randomTileUseCase;
  final RemoveTileUsecase tileRemove;
  TileRackCubit(this.randomTileUseCase, this.tileRemove)
    : super(TileRackInitial());
  void onGenerateRandomTile() async {
    emit(TileRackLoading());
    try {
      final randomTileData = await randomTileUseCase.call();
      emit(TileRackLoaded(randomTileData));
    } catch (e) {
      emit(TileRackError('random tile cubit error: $e'));
    }
  }

  void onTileRemove(Tile tile) async {
    // emit(TileRackLoading());
    try {
      final updatedRack = await tileRemove.call(tile);

      emit(TileRackLoaded(updatedRack));
      // emit(TileRackLoaded(randomTileData));
    } catch (e) {
      emit(TileRackError('random tile cubit error: $e'));
    }
  }

  Future<void> refillUntilSeven(LettersCubit lettersCubit) async {
    while (state is TileRackLoaded &&
        (state as TileRackLoaded).tileRack.length < 7 &&
        lettersCubit.totalTilesLeft > 0) {
      onGenerateRandomTile(); // ✅ No await
      await Future.delayed(Duration(milliseconds: 250));
    }
  }

}
