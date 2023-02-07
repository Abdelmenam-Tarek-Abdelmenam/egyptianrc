import 'package:bloc/bloc.dart';
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

    add(GetAdminDataEvent());
  }

  final DatabaseRepo _repo = DatabaseRepo();

  _getDataHandler(GetAdminDataEvent event, Emitter emit) async {
    emit(state.copyWith(status: BlocStatus.gettingData));
    Either<Failure, List<DisasterPost>> posts =
        await _repo.getActiveDisasters();

    posts.fold((left) {
      print("Here");
      left.show;
      emit(state.copyWith(status: BlocStatus.error));
    }, (right) {
      print("Here");
      emit(state.copyWith(status: BlocStatus.getData, active: right));
    });
  }
}
