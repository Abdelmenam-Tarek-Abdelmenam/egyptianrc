import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/asstes_manager.dart';
import 'no_connection_view.dart';

class SplashView extends StatefulWidget {
  const SplashView(
      {required this.child,
      this.menuIcon,
      this.action,
      this.title,
      this.showDivider = true,
      Key? key})
      : super(key: key);
  final Widget child;
  final String? title;
  final Widget? menuIcon;
  final Widget? action;
  final bool showDivider;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AnimationState animationFinished = AnimationState.idle;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        animationFinished = AnimationState.start;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        elevation: 0,
        actions: widget.action == null
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: widget.action!,
                )
              ],
        title: widget.title == null ? null : Text(widget.title!),
      ),
      body: Column(
        children: [
          animationFinished == AnimationState.end
              ? splashImage()
              : Expanded(child: splashImage()),
          AnimatedCrossFade(
              firstChild: Container(),
              secondChild: NoConnectionView(widget.child),
              crossFadeState: animationFinished.fadeState,
              duration: const Duration(milliseconds: 500)),
        ],
      ),
    );
  }

  Widget splashImage() => AnimatedAlign(
        onEnd: () {
          animationFinished = AnimationState.end;
          setState(() {});
        },
        duration: const Duration(seconds: 1),
        alignment: animationFinished == AnimationState.idle
            ? Alignment.center
            : Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Hero(
            tag: "Logo",
            child: Image.asset(
              AssetsManager.textLogo,
              width: 300.r,
            ),
          ),
        ),
      );
}

enum AnimationState {
  idle,
  start,
  end;

  CrossFadeState get fadeState =>
      this == end ? CrossFadeState.showSecond : CrossFadeState.showFirst;
}
