import 'package:flutter/material.dart';

import 'dividers.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_sharp,
              size: 100,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            Dividers.h15,
            FittedBox(
              child: Text(
                "Sorry we have a problem now try again later",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
