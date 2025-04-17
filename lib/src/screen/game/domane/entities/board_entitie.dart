

import 'package:scabbles_word/src/screen/game/domane/entities/board_tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';

class Board {
  final List<BoardTile> tiles;

  Board({required this.tiles});

  BoardTile getTile(int index) => tiles[index];

  bool isFirstMove() {
    return tiles.every((tile) => tile.value == null);
  }

  Board updateTile(int index, Tile value) {
    final updatedTiles =
        tiles.map((tile) {
          if (tile.index == index) {
            return tile.copyWith(value: value, isOccupied: true);
          }
          return tile;
        }).toList();

    return Board(tiles: updatedTiles);
  }
}
