import 'package:scabbles_word/src/screen/game/presentation/game_bord/ui/game_board.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
    builder: (context, constraints){
     if(constraints.maxWidth < 600){
       return DragDropGame();
     } else if(constraints.maxWidth >= 600 && constraints.maxWidth < 1200){
        return Container(
          color: Colors.cyan,
        );
     } else {
       return Container(
         color: Colors.red,
       );
     }
    },
    );
  }
}
