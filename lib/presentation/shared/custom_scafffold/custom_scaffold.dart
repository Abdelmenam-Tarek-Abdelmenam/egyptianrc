import 'package:flutter/material.dart';

import '../../resources/asstes_manager.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {required this.child, required this.title, this.action, Key? key})
      : super(key: key);
  final Widget child;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title),
        actions: action == null
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: action!,
                )
              ],
      ),
      body: Stack(
        children: [
          whiteDivider(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Hero(
                tag: "Logo",
                child: Image.asset(
                  AssetsManager.logo,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget whiteDivider(BuildContext context) => Divider(
        thickness: 2,
        height: 0,
        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
      );
}
