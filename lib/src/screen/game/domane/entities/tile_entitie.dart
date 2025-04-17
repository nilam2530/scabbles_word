// domain/entities/tile.dart
class Tile {
  final String kana;
  final String romaji;
  final String points;
  final List<dynamic> diacritics;

  Tile({
    required this.kana,
    required this.romaji,
    required this.points,
    required this.diacritics,
  });
}
