import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon(
      {required this.icon,
      required this.onPressed,
      this.active = false,
      Key? key})
      : super(key: key);
  final Widget icon;
  final Function() onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: IconButton(
              icon: icon,
              onPressed: onPressed,
            )),
        Positioned(
          top: 8,
          right: 8,
          child: Visibility(
            visible: active,
            child: CircleAvatar(
              radius: 5,
              backgroundColor: Theme.of(context).colorScheme.onError,
            ),
          ),
        ),
      ],
    );
  }
}
