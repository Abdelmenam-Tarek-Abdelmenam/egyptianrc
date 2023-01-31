import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingText extends StatelessWidget {
  const LoadingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "loading ",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 20),
          ),
          SpinKitThreeBounce(
            color: Theme.of(context).colorScheme.onBackground,
            size: 15,
          )
        ],
      ),
    );
  }
}
