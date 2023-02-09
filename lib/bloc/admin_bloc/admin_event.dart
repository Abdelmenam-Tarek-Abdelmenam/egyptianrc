part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {}

class GetAdminDataEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class NewDataEvent extends AdminEvent {
  final List<DisasterPost> data;
  NewDataEvent(this.data);

  @override
  List<Object?> get props => [data.length];
}

class ChangeViewModel extends AdminEvent {
  @override
  List<Object?> get props => [];
}

class BlockUserEvent extends AdminEvent {
  final int index;
  BlockUserEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ArchivePostEvent extends AdminEvent {
  final int index;
  ArchivePostEvent(this.index);

  @override
  List<Object?> get props => [index];
}
