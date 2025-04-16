// domain/repositories/game_repository.dart

import 'package:scabbles_word/src/screenns/game/domane/entities/board_entitie.dart';
import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart';

abstract class BoardRepo {
  Future<void> placeTile(int index, Tile tile);
  Future<Board> getBoardState();
}
