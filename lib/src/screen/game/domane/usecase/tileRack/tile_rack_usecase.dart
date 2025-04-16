import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/repo/tile_rack_repo.dart';

class TileRackUseCase {
  final TileRepository repository;

  TileRackUseCase(this.repository);

  Future<List<Tile>> call() {
    return repository.tileRack();
  }
}
