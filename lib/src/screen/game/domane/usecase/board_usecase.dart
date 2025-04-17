
import 'package:scabbles_word/src/screen/game/domane/entities/board_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';

class PlaceTileUseCase {
  Board call(Board board, int index, Tile tile) {
    final isFirstMove = board.isFirstMove();
    if (isFirstMove && index != 112) {
      throw Exception("First tile must be placed in the center");
    }

    final selectedTile = board.getTile(index);
    if (selectedTile.isOccupied) {
      throw Exception("This tile is already occupied");
    }

    return board.updateTile(index, tile);
  }
}
