import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/asstes_manager.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({required this.child, this.title, this.action, Key? key})
      : super(key: key);
  final Widget child;
  final String? title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        // title: Text(title),
        actions: action == null
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: action!,
                )
              ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: "Logo",
                    child: Image.asset(
                      AssetsManager.textLogo,
                      width: MediaQuery.of(context).size.width / 1.2,
                    ),
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
