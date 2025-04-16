
import 'package:scabbles_word/src/screen/game/data/data_source/tile_data_source.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/repo/tile_rack_repo.dart';

class TileRepoImpl implements TileRepository {
  final TileDataSource tileDataSource;

  TileRepoImpl(this.tileDataSource);

  @override
  Future<List<Tile>> tileRack() {
    try {
      return tileDataSource.tileRackGenerate();
    } catch (e) {
      throw Exception('tile repo impl error: $e');
    }
  }

  @override
  Future<List<Tile>> removeTileFromRack(Tile tile) {
    try {
      return tileDataSource.removeTile(tile);
    } catch (e) {
      throw Exception('tile repo impl error remove tile: $e');
    }
  }
}
