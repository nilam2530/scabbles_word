// application/board/board_state.dart
import 'package:scabbles_word/src/screen/game/domane/entities/board_entitie.dart';
import 'package:equatable/equatable.dart';

abstract class BoardState extends Equatable {
  const BoardState();
}

class BoardInitial extends BoardState {
  @override
  List<Object?> get props => [];
}

class BoardLoadInProgress extends BoardState {
  @override
  List<Object?> get props => [];
}

class BoardLoadSuccess extends BoardState {
  final Board board;
  final int? hoveredIndex;

  const BoardLoadSuccess(this.board, {this.hoveredIndex});

  @override
  List<Object?> get props => [board, hoveredIndex];
}

class BoardError extends BoardState {
  final String message;

  const BoardError(this.message);

  @override
  List<Object?> get props => [message];
}


