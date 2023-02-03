part of 'home_bloc.dart';

enum HomeStatus {
  home,
  post,
  location,
  account;

  @override
  String toString() {
    switch (this) {
      case HomeStatus.home:
        return StringManger.home;
      case HomeStatus.post:
        return StringManger.post;
      case HomeStatus.location:
        return StringManger.location;
      case HomeStatus.account:
        return StringManger.account;
    }
  }

  String toIcon() {
    switch (this) {
      case HomeStatus.home:
        return IconsManager.home;
      case HomeStatus.post:
        return IconsManager.post;
      case HomeStatus.location:
        return IconsManager.location;
      case HomeStatus.account:
        return IconsManager.person;
    }
  }

  Widget toWidget() {
    switch (this) {
      case HomeStatus.home:
        return const HomeView();
      case HomeStatus.post:
        return Container();
      case HomeStatus.location:
        return Container();
      case HomeStatus.account:
        return const UserView();
    }
  }
}
