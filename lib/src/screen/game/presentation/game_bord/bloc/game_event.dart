// application/board/board_event.dart
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:equatable/equatable.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();
}

class LoadBoard extends BoardEvent {
  @override
  List<Object?> get props => [];
}

class PlaceTile extends BoardEvent {
  final int index;
  final Tile tile;

  const PlaceTile({required this.index, required this.tile});

  @override
  List<Object?> get props => [index, tile];
}

// board_event.dart

class HoverTile extends BoardEvent {
  final int index;

  const HoverTile(this.index);

  @override
  List<Object?> get props => [index];
}

class UnhoverTile extends BoardEvent {
  final int index;

  const UnhoverTile(this.index);

  @override
  List<Object?> get props => [index];
}
