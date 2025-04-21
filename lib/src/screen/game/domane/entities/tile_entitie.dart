// domain/entities/tile.dart
// class Tile {
//   final String kana;
//   final String romaji;
//   final String points;
//   final List<dynamic> diacritics;

//   Tile({
//     required this.kana,
//     required this.romaji,
//     required this.points,
//     required this.diacritics,
//   });
// }

class Tile {
  final String id;
  final String kana;
  final String romaji;
  final String points;
  final List<dynamic> diacritics;

  Tile({
    required this.id,
    required this.kana,
    required this.romaji,
    required this.points,
    required this.diacritics,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tile &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

