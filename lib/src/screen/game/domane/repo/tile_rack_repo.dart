
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';

abstract class TileRepository {
  Future<List<Tile>> tileRack();
  Future<List<Tile>> removeTileFromRack(Tile tile);
}
