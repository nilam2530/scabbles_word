import 'dart:developer';
// import 'package:scabbles_word/src/screenns/game/domane/entities/tile_entitie.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.60), // subtle white overlay
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(color: Colors.black.withOpacity(0.3)), // Dark overlay

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text('Bingo kana',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            centerTitle: true,
            actions: [
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
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
                                final hasDiacritics =
                                    letter.diacritics.isNotEmpty;
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
                                return CustomPopup(
                                  content: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        letter.diacritics.map<Widget>((
                                          innerList,
                                        ) {
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
                      return Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                      );
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
                      if (state is BoardLoadInProgress ||
                          state is BoardInitial) {
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
                                transformationController:
                                    transformationController,
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
                                          // log(index.toString());
                                          return true;
                                        }
                                        return false;
                                      },
                                      onLeave: (data) {
                                        context.read<BoardBloc>().add(
                                          UnhoverTile(index),
                                        );
                                      },
                                      onAcceptWithDetails: (details) {
                                        final tile = details.data;

                                        final isFirstMove =
                                            state.board.isFirstMove();

                                        if (isFirstMove && index != 112) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'First tile must be placed in the center',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        context.read<BoardBloc>().add(
                                          PlaceTile(index: index, tile: tile),
                                        );

                                        GetIt.I<TileRackCubit>().onTileRemove(
                                          tile,
                                        );
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
                                              // image: DecorationImage(
                                              //   image: AssetImage("assets/images/box.jpg"),
                                              //   fit: BoxFit.cover,
                                              //
                                              // ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                  AnimatedButton(
                    height: 50,
                    width: 100,
                    text: 'SUBMIT',
                    textStyle: TextStyle(color: Colors.orange,fontSize: 18,fontWeight:  FontWeight.bold),
                    isReverse: true,
                    selectedTextColor: Colors.orange,
                    transitionType: TransitionType.CENTER_ROUNDER,
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    borderRadius: 50,
                    borderWidth: 2,
                    onPress: () async {
                      final boardBloc = context.read<BoardBloc>();
                      final placedTiles = boardBloc.placedTiles;

                      if (placedTiles.isEmpty) {
                        CustomToast.show(context, message: "No tiles placed.");
                        return;
                      }

                      debugPrint(
                        "Words placed: ${placedTiles.map((e) => e.value?.kana).join()}",
                      );

                      // Clear placed tiles on board
                      //  boardBloc.clearPlacedTiles();

                      // Refill logic
                      final tileRackCubit = context.read<TileRackCubit>();
                      final lettersCubit = context.read<LettersCubit>();

                      while (tileRackCubit.state is TileRackLoaded &&
                          (tileRackCubit.state as TileRackLoaded)
                              .tileRack
                              .length <
                              7 &&
                          lettersCubit.totalTilesLeft > 0) {
                        await tileRackCubit.refillUntilSeven(
                          context.read<LettersCubit>(),
                        );
                        await Future.delayed(
                          Duration(milliseconds: 300),
                        ); // optional delay
                      }

                      // Optional: Navigate somewhere
                      // Navigator.push(...)
                    },
                  ),

                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      tileBag(context: context,letters: letters);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/money-bag.png',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                        ),
                       Positioned(
                         top: 25,
                           child:
                       Text('${context.watch<LettersCubit>().totalTilesLeft}',style: TextStyle(color: Colors.orange,fontWeight:  FontWeight.bold,fontSize: 18),))


                                            ],
                    ),
                  ),
                ),
              ],
            ),
          ),        ),
      ],
    );
  }
}
