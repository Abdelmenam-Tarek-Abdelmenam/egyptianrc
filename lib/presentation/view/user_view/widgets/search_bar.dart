import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../resources/asstes_manager.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: StringManger.searchOnTheMap,

      hintStyle: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: Colors.grey, fontSize: 18.sp),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      height: 40.h,
      // backdropColor: Colors.black,

      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      leadingActions: [
        FloatingSearchBarAction.icon(
          size: 25.r,
          showIfOpened: false,
          icon: SvgPicture.asset(IconsManager.search, fit: BoxFit.fill),
          onTap: () {},
          showIfClosed: true,
        ),
      ],
      queryStyle: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: Colors.black, fontSize: 18.sp),
      width: isPortrait ? 320.w : 500.w,
      debounceDelay: const Duration(milliseconds: 200),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      // transition: SlideFadeFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.icon(
          showIfOpened: true,
          icon: SvgPicture.asset(IconsManager.micSearch),
          onTap: () {},
          // showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(
                  height: 112,
                  color: Colors.white,
                  // child: Text('data'),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
