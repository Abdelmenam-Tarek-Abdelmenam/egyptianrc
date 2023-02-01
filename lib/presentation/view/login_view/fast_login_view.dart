import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

import '../../shared/custom_scafffold/custom_scaffold.dart';

class FastLoginView extends StatelessWidget {
  const FastLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringManger.fastLogin,
            style: Theme.of(context).textTheme.headlineLarge,
          )
        ],
      )),
    );
  }
}
