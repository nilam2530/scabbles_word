import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scabbles_word/src/utils/cubit/letters_cubit.dart';

void tileBag({context, letters}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      // Total remaining tiles

      return Container(

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
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.60), // subtle white overlay
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              color: count > 0 ? Colors.black : Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
