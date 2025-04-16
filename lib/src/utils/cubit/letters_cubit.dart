import 'package:flutter_bloc/flutter_bloc.dart';

class LettersCubit extends Cubit<Map<String, List<dynamic>>> {
  LettersCubit(this._initialLetters) : super(Map.from(_initialLetters));

  final Map<String, List<dynamic>> _initialLetters;

  void decrementTileCount(String kana) {
    final updated = Map<String, List<dynamic>>.from(state);
    if (updated[kana] != null && updated[kana]![2] > 0) {
      updated[kana]![2] = updated[kana]![2] - 1;
      emit(updated);
    }
  }

  int get totalTilesLeft {
    return state.entries.fold(0, (sum, entry) {
      final count = entry.value[2] as int;
      return sum + count;
    });
  }

  // Optional: reset or update letters map
  void resetLetters() => emit(Map.from(_initialLetters));
}
