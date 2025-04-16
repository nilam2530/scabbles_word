import 'package:scabbles_word/src/buttons/primary_button.dart';
import 'package:scabbles_word/src/const/app_sizes.dart';
import 'package:scabbles_word/src/utils/string_hardcoded_ext.dart';
import 'package:flutter/material.dart';

/// Placeholder widget showing a message and CTA to go back to the home screen.
class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            PrimaryButton(
              //onPressed: () => context.goNamed(AppRoute.login.name),
              onPressed: () {},
              text: 'Go Home'.hardcoded,
            )
          ],
        ),
      ),
    );
  }
}
