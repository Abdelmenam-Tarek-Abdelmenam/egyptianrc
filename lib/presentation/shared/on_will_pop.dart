import 'package:flutter/material.dart';

import '../resources/string_manager.dart';

Future<bool> showMyDialog(BuildContext context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(StringManger.warning,
              style: Theme.of(context).textTheme.displayLarge),
          content: Text(
            StringManger.exitQ,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                StringManger.no,
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                StringManger.yes,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      )) ??
      false;
}
