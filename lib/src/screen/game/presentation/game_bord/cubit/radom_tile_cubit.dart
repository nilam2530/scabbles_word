import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/remove_tile_usecase.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/tileRack/tile_rack_usecase.dart';

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

  void onTileUpdate(Tile oldTile, Tile newTile) {
    if (state is TileRackLoaded) {
      final currentRack = (state as TileRackLoaded).tileRack;
      final updatedRack = List<Tile>.from(currentRack);

      final index = updatedRack.indexOf(
        oldTile,
      ); // <- This compares by object identity

      if (index != -1) {
        updatedRack[index] = newTile;
        emit(TileRackLoaded(updatedRack));
      }
    }
  }
}
