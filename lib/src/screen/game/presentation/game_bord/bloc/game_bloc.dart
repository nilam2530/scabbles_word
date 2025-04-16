import 'package:scabbles_word/src/screen/game/domane/entities/board_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/board_tile_entitie.dart';
import 'package:scabbles_word/src/screen/game/domane/usecase/board_usecase.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_event.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final PlaceTileUseCase placeTileUseCase;

  late Board _board; // in-memory board

  BoardBloc({required this.placeTileUseCase}) : super(BoardInitial()) {
    on<LoadBoard>((event, emit) async {
      emit(BoardLoadInProgress());
      _board = Board(
        tiles: List.generate(225, (i) {
          return BoardTile(index: i, isCenter: i == 112);
        }),
      );
      emit(BoardLoadSuccess(_board));
    });

    on<PlaceTile>((event, emit) {
      try {
        final newBoard = placeTileUseCase(_board, event.index, event.tile);
        _board = newBoard;
        emit(BoardLoadSuccess(_board));
      } catch (e) {
        emit(BoardError(e.toString()));
        emit(BoardLoadSuccess(_board)); // return to current board after error
      }
    });


    on<HoverTile>((event, emit) {
      emit(BoardLoadSuccess(_board, hoveredIndex: event.index));
    });

    on<UnhoverTile>((event, emit) {
      emit(BoardLoadSuccess(_board)); // clears hoveredIndex
    });
  }
}
