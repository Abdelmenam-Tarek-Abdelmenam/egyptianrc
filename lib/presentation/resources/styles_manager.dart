import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleManager {
  static final List<BoxShadow> smallShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(0, 2), // changes position of shadow
    ),
  ];
  static final List<BoxShadow> bigShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.8),
      spreadRadius: 2,
      blurRadius: 2,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ];

  static const BorderRadius border = BorderRadius.all(
    Radius.circular(10),
  );

  static const Radius radius10 = Radius.circular(10);
  static final Radius radius15 = Radius.circular(15.r);

  static ButtonStyle signBtnStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          radius15.r,
        ),
      ),
    ),
  );
}

class PaddingManager {
  static const p2 = EdgeInsets.all(2.0);
  static const p4 = EdgeInsets.all(4.0);
  static const p8 = EdgeInsets.all(8.0);
  static const p10 = EdgeInsets.all(10.0);
  static const p15 = EdgeInsets.all(15.0);
}
