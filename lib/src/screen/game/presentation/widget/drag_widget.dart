import 'package:scabbles_word/src/screen/game/domane/entities/tile_entitie.dart';
import 'package:flutter/material.dart';

Widget dragWidget(
  Tile tileData,
  double opacity, {
  double fontsize = 22,
  double? letterPadding,
  bool usinngAsfeedback = false,
}) {
  return Opacity(
    opacity: opacity,
    child: Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/color.jpg")),
        color: Colors.amber,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: letterPadding ?? 0.0),
              child: Text(
                tileData.kana,
                style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          usinngAsfeedback
              ? SizedBox.shrink()
              : Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 1),
                  child:
                      // ignore: unnecessary_null_comparison
                      tileData.points == null
                          ? Text('')
                          : Text(tileData.points),
                ),
              ),

          usinngAsfeedback
              ? SizedBox.shrink()
              : Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 1),
                  child:
                      // ignore: unnecessary_null_comparison
                      tileData.romaji == null
                          ? SizedBox.shrink()
                          : Text(tileData.romaji),
                ),
              ),
          usinngAsfeedback
              ? SizedBox.shrink()
              : Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child:
                      tileData.diacritics.isNotEmpty
                          ? CircleAvatar(backgroundColor: Colors.red, radius: 3)
                          : SizedBox.shrink(),
                ),
              ),
        ],
      ),
    ),
  );
}
//* Demo widget
Widget dragWidget1(
  String text,
  double scale, {
  double fontsize = 16,
  bool showPoint = true,
}) {
  return Transform.scale(
    scale: scale,
    child: Text(
      text,
      style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.bold),
    ),
  );
}
