import 'package:bloc/bloc.dart';
import 'package:egyptianrc/data/models/app_user.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/error_state.dart';
import '../../data/models/disaster_post.dart';
import '../../domain_layer/repository_implementer/firestore_repo.dart';
import '../status.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminState.initial()) {
    on<GetAdminDataEvent>(_getDataHandler);
    on<ChangeViewModel>(_changeViewModel);
    on<NewDataEvent>(_newDataAdded);
    on<BlockUserEvent>(_blockUser);
    on<ArchivePostEvent>(_archivePost);

    add(GetAdminDataEvent());
  }

  final DatabaseRepo _repo = DatabaseRepo();

  _blockUser(BlockUserEvent event, Emitter emit) async {
    AppUser user;
    if (state.viewMode == AdminViewMode.active) {
      user = state.active[event.index].user!..panned = true;
    } else {
      user = state.archived[event.index].user!..panned = true;
    }
    Either<Failure, void> posts = await _repo.editUser(user);

    posts.fold((left) {
      left.show;
      emit(state.copyWith(status: BlocStatus.error));
    }, (right) {
      showToast("User Panned Successfully");
      emit(state.copyWith(status: BlocStatus.getData));
    });
  }

  _archivePost(ArchivePostEvent event, Emitter emit) async {
    DisasterPost post;
    if (state.viewMode == AdminViewMode.active) {
      post = state.active[event.index];
    } else {
      post = state.archived[event.index];
    }
    Either<Failure, void> posts = await _repo.setArchivePost(post);

    posts.fold((left) {
      left.show;
      emit(state.copyWith(status: BlocStatus.error));
    }, (right) {
      showToast("Post Archived Successfully");
      state.active.removeAt(event.index);
      emit(state.copyWith(status: BlocStatus.getData));
    });
  }

  _newDataAdded(NewDataEvent event, Emitter emit) async {
    event.data.sort((r, l) => r.time.compareTo(l.time));
    showToast("New Disaster Come", type: ToastType.info);

    emit(state.copyWith(active: event.data));
  }

  _getDataHandler(GetAdminDataEvent event, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));

    _repo.addListener((newPosts) {
      add(NewDataEvent(newPosts));
    });

    Either<Failure, List<DisasterPost>> posts =
        await _repo.getActiveDisasters();

    posts.fold((left) {
      left.show;
      emit(state.copyWith(status: BlocStatus.error));
    }, (right) {
      emit(state.copyWith(status: BlocStatus.getData, active: right));
    });
  }

  _changeViewModel(ChangeViewModel event, Emitter emit) async {
    if (state.viewMode == AdminViewMode.active) {
      await _getArchiveHandler(emit);
    } else {
      emit(state.copyWith(viewMode: AdminViewMode.active));
      if (state.active.isEmpty) {
        add(GetAdminDataEvent());
      }
    }
  }

  _getArchiveHandler(Emitter emit) async {
    if (state.archived.isNotEmpty) {
      emit(state.copyWith(viewMode: AdminViewMode.archive));
      return;
    }
    emit(state.copyWith(
        status: BlocStatus.gettingData, viewMode: AdminViewMode.archive));
    Either<Failure, List<DisasterPost>> posts =
        await _repo.getArchiveDisasters();

    posts.fold((left) {
      left.show;
      emit(state.copyWith(status: BlocStatus.error));
    }, (right) {
      emit(state.copyWith(status: BlocStatus.getData, archived: right));
    });
  }
}
