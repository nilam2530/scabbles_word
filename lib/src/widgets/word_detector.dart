class WordDetector {
  final int boardSize = 15;

  List<String> extractWord(Map<int, String?> board, int index) {
    // String getTile(int i) => board[i] ?? '';

    // --- Horizontal --- //
    int start = index;
    while (start % boardSize != 0 && board[start - 1] != null) {
      start--;
    }

    String horizontal = '';
    int i = start;
    while (i % boardSize != 0 || i == start) {
      if (board[i] == null) break;
      horizontal += board[i]!;
      i++;
      if (i % boardSize == 0) break;
    }

    // --- Vertical ---
    start = index;
    while (start >= boardSize && board[start - boardSize] != null) {
      start -= boardSize;
    }

    String vertical = '';
    i = start;
    while (i < boardSize * boardSize) {
      if (board[i] == null) break;
      vertical += board[i]!;
      i += boardSize;
    }

    return [horizontal, vertical];
  }

  List<String> extractAllWords(Map<int, String?> board) {
    final Set<String> foundWords = {};
    for (var entry in board.entries) {
      if (entry.value != null) {
        final words = extractWord(board, entry.key);
        for (var word in words) {
          if (word.length > 1) foundWords.add(word);
        }
      }
    }
    return foundWords.toList();
  }

bool isValidWord(List<String> wordList, List<String> dictionary) =>
    wordList.any((word) => dictionary.contains(word));


  // List<String> getValidWords(Map<int, String?> board, Set<String> dictionary) {
  //   return extractAllWords(
  //     board,
  //   ).where((word) => isValidWord(word, dictionary)).toList();
  // }
}
