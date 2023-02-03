import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/home_bloc/home_bloc.dart';
import '../../../shared/widget/customs_icons.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStatus>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
          onTap: (i) => context.read<HomeBloc>().add(ChangeHomePage(i)),
          items: HomeStatus.values
              .map((e) => BottomNavigationBarItem(
                  icon: CustomIcon(e.toIcon(),
                      color: e == state
                          ? Theme.of(context).colorScheme.primary
                          : null),
                  label: e.toString()))
              .toList(),
        );
      },
    );
  }
}
