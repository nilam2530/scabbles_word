import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screenns/game/domane/repo/tile_rack_repo.dart';

class RemoveTileUsecase {
  final TileRepository repository;

  RemoveTileUsecase(this.repository);

  Future<List<Tile>> call(Tile tile) {
    return repository.removeTileFromRack(tile);
  }
}
