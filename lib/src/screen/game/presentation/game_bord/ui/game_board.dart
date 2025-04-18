import 'dart:developer';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart'
    show Tile;
import 'package:scabbles_word/src/screen/game/presentation/game_bord/cubit/radom_tile_cubit.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_bloc.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_event.dart';
import 'package:scabbles_word/src/screen/game/presentation/game_bord/bloc/game_state.dart';
import 'package:scabbles_word/src/screen/game/presentation/widget/drag_widget.dart';
import 'package:scabbles_word/src/screen/game/presentation/widget/tilebag.dart';
import 'package:scabbles_word/src/screen/game/presentation/widget/word_list.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';
import 'package:scabbles_word/src/utils/toaster.dart';
import 'package:scabbles_word/src/widgets/colors_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DragDropGame extends StatelessWidget {
  const DragDropGame({super.key});

  @override
  Widget build(BuildContext context) {
    final int gridSize = 15;
    final TransformationController transformationController =
        TransformationController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Bingo kana'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              tileBag(context: context, letters: letters);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                shape: BoxShape.circle,
                // borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  '${context.watch<LettersCubit>().totalTilesLeft}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Draggable Items
              BlocBuilder<TileRackCubit, TileRackState>(
                builder: (context, state) {
                  if (state is TileRackLoading) {
                    return CircularProgressIndicator();
                  }
                  if (state is TileRackLoaded) {
                    return Wrap(
                      spacing: 5,
                      children:
                          state.tileRack.map((letter) {
                            final hasDiacritics = letter.diacritics.isNotEmpty;

                            Widget draggableTile = Draggable<Tile>(
                              data: letter,
                              feedback: dragWidget(
                                letter,
                                0.5,
                                usinngAsfeedback: true,
                                fontsize: 26,
                                letterPadding: 10,
                              ),
                              childWhenDragging: SizedBox.shrink(),
                              child: dragWidget(letter, 1.0),
                            );

                            if (!state.tileRack.contains(letter)) {
                              return SizedBox.shrink();
                            }

                            if (!hasDiacritics) {
                              return GestureDetector(
                                onTap: () {}, // optional placeholder
                                child: draggableTile,
                              );
                            }

                            // If letter has diacritics, show with popup
                            return CustomPopup(
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    letter.diacritics.map<Widget>((innerList) {
                                      if (innerList.length < 2) {
                                        return SizedBox.shrink();
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .read<TileRackCubit>()
                                                .onTileUpdate(
                                                  letter,
                                                  Tile(
                                                    id: letter.id,
                                                    kana: innerList[0],
                                                    romaji: innerList[1],
                                                    points: letter.points,
                                                    diacritics: [],
                                                  ),
                                                );
                                            Navigator.pop(context);
                                          },

                                          child: dragWidget(
                                            Tile(
                                              id: letter.id,
                                              kana: innerList[0],
                                              romaji: innerList[1],
                                              points: letter.points,
                                              diacritics: [],
                                            ),
                                            1,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                              child: draggableTile,
                            );
                          }).toList(),
                    );
                  }
                  if (state is TileRackError) {
                    return Container(
                      // width: 20,
                      height: 120,
                      color: Colors.red,
                      child: Text(state.error),
                    );
                  }
                  return Container(width: 20, height: 20, color: Colors.green);
                },
              ),
              // Drop Target Grid
              SizedBox(height: 20),
              BlocConsumer<BoardBloc, BoardState>(
                listener: (context, state) {
                  if (state is BoardError) {
                    // ScaffoldMessenger.of(
                    //   context,
                    // ).showSnackBar(SnackBar(content: Text(state.message)));
                    CustomToast.show(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is BoardLoadInProgress || state is BoardInitial) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is BoardLoadSuccess) {
                    final board = state.board;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: InteractiveViewer(
                            transformationController: transformationController,
                            minScale: 1.0,
                            maxScale: 2.0,
                            child: GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: gridSize,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: gridSize * gridSize,
                              itemBuilder: (context, index) {
                                final tile = board.tiles[index];

                                return DragTarget<Tile>(
                                  onWillAcceptWithDetails: (details) {
                                    if (tile.value == null) {
                                      context.read<BoardBloc>().add(
                                        HoverTile(index),
                                      );
                                      log(index.toString());
                                      return true;
                                    }
                                    return false;
                                  },
                                  onLeave: (data) {
                                    context.read<BoardBloc>().add(
                                      UnhoverTile(index),
                                    );
                                  },

                                  // Use onAcceptWithDetails instead of onAccept
                                  onAcceptWithDetails: (details) {
                                    final tile =
                                        details
                                            .data; // Access the dragged data from the details

                                    context.read<BoardBloc>().add(
                                      PlaceTile(index: index, tile: tile),
                                    );
                                    GetIt.I<TileRackCubit>().onTileRemove(tile);
                                  },
                                  builder: (
                                    context,
                                    candidateData,
                                    rejectedData,
                                  ) {
                                    final isHovered =
                                        (state).hoveredIndex == index;
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                          color:
                                              isHovered
                                                  ? Colors.yellow
                                                  : tileColor(tile),
                                        ),
                                        alignment: Alignment.center,
                                        child:
                                            tile.value == null
                                                ? null
                                                : Draggable<Tile>(
                                                  data: tile.value!,
                                                  feedback: dragWidget1(
                                                    tile.value!.kana,
                                                    0.5,
                                                  ),
                                                  childWhenDragging:
                                                      SizedBox.shrink(),
                                                  child: dragWidget1(
                                                    tile.value!.kana,
                                                    1.0,
                                                  ),
                                                ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: Text('Unexpected state'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DragDropGame extends StatefulWidget {
//   const DragDropGame({super.key});

//   @override
//   State<DragDropGame> createState() => _DragDropGameState();
// }

// class _DragDropGameState extends State<DragDropGame> {
//   final int gridSize = 15;
//   final TransformationController transformationController = TransformationController();
//   OverlayEntry? _overlayEntry;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final cubit = context.read<TileRackCubit>();

//     cubit.stream.listen((state) {
//       if (state is TileRackLoaded) {
//         if (state.isOverlayVisible && cubit.overlayPosition != null) {
//           _showOverlay(context, cubit.overlayPosition!);
//         } else {
//           _removeOverlay();
//         }
//       }
//     });
//   }

//   void _showOverlay(BuildContext context, Offset position) {
//     _removeOverlay();

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: position.dy,
//         left: position.dx,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Color(0xffFFFDD0),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     log('A pressed');
//                     context.read<TileRackCubit>().dismissOverlay();
//                   },
//                   child: Text('A'),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     log('B pressed');
//                     context.read<TileRackCubit>().dismissOverlay();
//                   },
//                   child: Text('B'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );

//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Bingo kana'), centerTitle: true),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               BlocBuilder<TileRackCubit, TileRackState>(
//                 builder: (context, state) {
//                   if (state is TileRackLoading) return CircularProgressIndicator();
//                   if (state is TileRackLoaded) {
//                     return Wrap(
//                       spacing: 5,
//                       children: state.tileRack.map((tile) {
//                         return GestureDetector(
//                           onTapDown: (details) {
//                             final tapPosition = details.globalPosition;
//                             context.read<TileRackCubit>().requestOverlayAt(tapPosition);
//                           },
//                           child: Draggable<Tile>(
//                             data: tile,
//                             feedback: dragWidget(
//                               tile,
//                               0.5,
//                               usinngAsfeedback: true,
//                               fontsize: 26,
//                               letterPadding: 10,
//                             ),
//                             childWhenDragging: SizedBox.shrink(),
//                             child: dragWidget(tile, 1.0),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   }
//                   if (state is TileRackError) {
//                     return Container(
//                       height: 120,
//                       color: Colors.red,
//                       child: Text(state.error),
//                     );
//                   }
//                   return Container(width: 20, height: 20, color: Colors.green);
//                 },
//               ),
//               SizedBox(height: 20),
//               // BOARD GRID RENDERING SKIPPED FOR BREVITY — KEEP YOURS HERE
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
