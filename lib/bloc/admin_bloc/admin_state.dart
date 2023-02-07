part of 'admin_bloc.dart';

class AdminState extends Equatable {
  final List<DisasterPost> archived;
  final List<DisasterPost> active;
  final BlocStatus status;

  const AdminState(
      {required this.status, required this.archived, required this.active});

  factory AdminState.initial() =>
      const AdminState(status: BlocStatus.idle, archived: [], active: []);

  AdminState copyWith({
    List<DisasterPost>? archived,
    List<DisasterPost>? active,
    BlocStatus? status,
  }) =>
      AdminState(
        status: status ?? this.status,
        archived: archived ?? this.archived,
        active: active ?? this.active,
      );

  @override
  List<Object?> get props => [status, archived.length, active.length];
}
