import 'dart:math' as math;

import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/presentation/widget/word_list.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

abstract class TileDataSource {
  Future<List<Tile>> tileRackGenerate();
  Future<List<Tile>> removeTile(Tile tile);
}

class TileDataSourceImpl implements TileDataSource {
  final List<Tile> newRack = [];
  @override
  Future<List<Tile>> tileRackGenerate() async {
    try {
      while (newRack.length < 7) {
        final letter = getRandomAvailableLetters();
        if (letter != null) {
          newRack.add(
            Tile(
              id: Uuid().v4(),
              kana: letter,
              romaji: letters[letter]![0],
              points: letters[letter]![3].toString(),
              diacritics: letters[letter]![1],
            ),
          );
          GetIt.I<LettersCubit>().decrementTileCount(letter);
        } else {
          break;
        }
      }
      GetIt.I<LettersCubit>().totalTilesLeft;
      return newRack;
    } catch (e) {
      throw Exception('tile data source error: $e');
    }
  }

  String? getRandomAvailableLetters() {
    try {
      final availableLetters =
          letters.entries
              .where((entry) => entry.value[2] > 0)
              .map((entry) => entry.key)
              .toList();

      if (availableLetters.isEmpty) return null;

      final random = math.Random();
      return availableLetters[random.nextInt(availableLetters.length)];
    } catch (e) {
      throw Exception('tile data source error: $e');
    }
  }

  @override
  Future<List<Tile>> removeTile(Tile tile) async {
    // newRack.remove(tile);
    newRack.removeWhere((t) => t.id == tile.id);

    return newRack;
  }

  // @override
  // Future<List<Tile>> removeTile(Tile tile) async {
  //   final index = newRack.indexWhere(
  //     (t) => t.kana == tile.kana && t.romaji == tile.romaji,
  //   );
  //   if (index != -1) {
  //     newRack.removeAt(index);
  //   }
  //   return newRack;
  // }
}
