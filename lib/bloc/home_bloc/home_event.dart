part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangeHomePage extends HomeEvent {
  final HomeStatus status;
  ChangeHomePage(int index) : status = HomeStatus.values[index];

  @override
  List<Object?> get props => [status];
}
