import 'package:flutter/material.dart';

import '../../../../shared/widget/error_image.dart';

const noImage =
    "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg";

class Avatar extends StatelessWidget {
  const Avatar(this.url, this.width, {Key? key}) : super(key: key);
  final String? url;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      radius: width / 2 + 1,
      child: ClipOval(
        child: ErrorImage(
          url ?? noImage,
          fit: BoxFit.cover,
          width: width,
          height: width,
        ),
      ),
    );
  }
}
