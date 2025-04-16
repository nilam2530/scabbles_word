import 'dart:developer';
// import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart';
import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart' show Tile;
import 'package:scabbles_word/src/screenns/game/presentation/cubit/radom_tile_cubit.dart';
import 'package:scabbles_word/src/screenns/game/presentation/screen/game_bord/bloc/game_bloc.dart';
import 'package:scabbles_word/src/screenns/game/presentation/screen/game_bord/bloc/game_event.dart';
import 'package:scabbles_word/src/screenns/game/presentation/screen/game_bord/bloc/game_state.dart';
import 'package:scabbles_word/src/screenns/game/presentation/widget/drag_widget.dart';
import 'package:scabbles_word/src/screenns/game/presentation/widget/word_list.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';
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
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  // Total remaining tiles

                  return SizedBox(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${context.watch<LettersCubit>().totalTilesLeft} tiles remaining in the bag',
                          ),
                          Divider(),

                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 3,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: letters.length,
                              itemBuilder: (context, index) {
                                String letter = letters.keys.elementAt(index);
                                int count = letters[letter]![2];

                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color:
                                        count > 0
                                            ? Colors.amber[300]
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Center(
                                        child: Text(
                                          letter,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      count.toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                        count > 0
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
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
                        // if (droppedValues.containsValue(letter)) {
                        //   return SizedBox.shrink();
                        // }
          
                        return GestureDetector(
                          onTap: () {
                            // log('Long press on ${letter.diacritics}');
                            log('Long press on ${state.tileRack.length}');
                          },
                          child:
                          state.tileRack.contains(letter)
                              ? Draggable<Tile>(
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
                          )
                              : SizedBox.shrink(),
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
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
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
                                      onTap: () {
                                        // if (tile.index == null) {
          
                                        // }
                                        // log(
                                        //   board.tiles[index + 1].value!.kana
                                        //       .toString(),
                                        // );
                                        // log('tile index ${tile.index}');
                                        // log('top index ${index - 15}');
                                        // log('bottom index ${index + 15}');
                                        // log('next index ${index + 1}');
                                        // log('previous index ${index - 1}');
                                      },
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
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
          
                                //   DragTarget<Tile>(
                                //   onWillAcceptWithDetails: (details) {
                                //     if (tile.value == null) {
                                //       context.read<BoardBloc>().add(
                                //         HoverTile(index),
                                //       );
                                //       return true;
                                //     }
                                //     return false;
                                //   },
                                //   onLeave: (data) {
                                //     context.read<BoardBloc>().add(
                                //       UnhoverTile(index),
                                //     );
                                //   },
                                //
                                //   onAccept: (data) {
                                //     context.read<BoardBloc>().add(
                                //       PlaceTile(index: index, tile: data),
                                //     );
                                //     GetIt.I<TileRackCubit>().onTileRemove(data);
                                //   },
                                //   builder: (
                                //     context,
                                //     candidateData,
                                //     rejectedData,
                                //   ) {
                                //     final isHovered =
                                //         (state).hoveredIndex == index;
                                //     return GestureDetector(
                                //       onTap: () {
                                //         // log(tile.value);
                                //       },
                                //       child: Container(
                                //         width: 25,
                                //         height: 25,
                                //         decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(5),
                                //           color:
                                //               isHovered
                                //                   ? Colors.yellow
                                //                   : tileColor(tile),
                                //         ),
                                //         alignment: Alignment.center,
                                //         child:
                                //             tile.value == null
                                //                 ? null
                                //                 : Draggable<Tile>(
                                //                   data: tile.value!,
                                //                   feedback: dragWidget1(
                                //                     tile.value!.kana,
                                //                     0.5,
                                //                   ),
                                //                   childWhenDragging:
                                //                       SizedBox.shrink(),
                                //                   child: dragWidget1(
                                //                     tile.value!.kana,
                                //                     1.0,
                                //                   ),
                                //                 ),
                                //       ),
                                //     );
                                //   },
                                // );
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


