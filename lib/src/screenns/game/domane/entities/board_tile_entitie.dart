
import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart';

class BoardTile {
  final int index;
  final Tile? value; 
  final bool isCenter;
  final bool isOccupied;

  BoardTile({
    required this.index,
    this.value,
    this.isCenter = false,
    this.isOccupied = false,
  });

  BoardTile copyWith({
    Tile? value,
    bool? isOccupied,
  }) {
    return BoardTile(
      index: index,
      value: value ?? this.value,
      isCenter: isCenter,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }
}
