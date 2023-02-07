part of 'admin_bloc.dart';

class AdminState extends Equatable {
  final List<DisasterPost> archived;
  final List<DisasterPost> active;
  final BlocStatus status;
  final AdminViewMode viewMode;

  const AdminState(
      {required this.status,
      required this.archived,
      required this.active,
      required this.viewMode});

  factory AdminState.initial() => const AdminState(
      status: BlocStatus.idle,
      archived: [],
      active: [],
      viewMode: AdminViewMode.active);

  AdminState copyWith({
    List<DisasterPost>? archived,
    List<DisasterPost>? active,
    BlocStatus? status,
    AdminViewMode? viewMode,
  }) =>
      AdminState(
        status: status ?? this.status,
        archived: archived ?? this.archived,
        active: active ?? this.active,
        viewMode: viewMode ?? this.viewMode,
      );

  @override
  List<Object?> get props => [status, archived.length, active.length, viewMode];
}

enum AdminViewMode { archive, active }
