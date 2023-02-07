part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {}

class GetAdminDataEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class ChangeViewModel extends AdminEvent {
  @override
  List<Object?> get props => [];
}
