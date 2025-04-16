import 'package:scabbles_word/src/screenns/game/domane/entities/board_tile_entitie.dart';
import 'package:flutter/material.dart';


Color tileColor(BoardTile tile) {
  if (tile.isOccupied) return Colors.yellow;
  if (tile.isCenter) return Colors.blue;
  return Colors.grey;
}