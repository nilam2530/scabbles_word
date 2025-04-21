import 'package:scabbles_word/src/screen/game/domane/entities/board_tile_entitie.dart';
import 'package:flutter/material.dart';

List<Color> tileColor(BoardTile tile) {
  if (tile.isOccupied) return [Color(0xfffd6900), Color(0xffffcc00)];
  if (tile.isCenter) return [Colors.blue, Colors.blue];
  return [Colors.white, Colors.white];
}
