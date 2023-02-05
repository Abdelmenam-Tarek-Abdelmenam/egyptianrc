import 'package:bloc/bloc.dart';
import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/domain_layer/validator.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/error_state.dart';
import '../../domain_layer/repository_implementer/firestore_repo.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserStatus> {
  EditUserBloc() : super(EditUserStatus.idle) {
    on<EditNameEvent>(_editNameHandler);
    on<EditEmailEvent>(_editEmailHandler);
    on<EditPhonesEvent>(_editPhonesHandler);
    on<EditPasswordEvent>(_editPasswordHandler);
    on<EditUserAddress>(_editAddressHandler);
  }
// AuthBloc.user

  final DatabaseRepo _repo = DatabaseRepo();

  Future<void> _editNameHandler(EditNameEvent event, emit) async {
    emit(EditUserStatus.editing);
    Either<Failure, void> value =
        await _repo.editUser(AuthBloc.user.copyWith(name: event.name));

    value.fold((left) {
      left.show;
      emit(EditUserStatus.error);
    }, (right) {
      AuthBloc.user.name = event.name;
      emit(EditUserStatus.edited);
    });
  }

  Future<void> _editEmailHandler(EditEmailEvent event, emit) async {
    emit(EditUserStatus.editing);
    if (!validateEmail(event.email)) {
      showToast("هذا الايميل غير صحيح");
      emit(EditUserStatus.error);
      return;
    }
    Either<Failure, void> value =
        await _repo.editUser(AuthBloc.user.copyWith(email: event.email));

    value.fold((left) {
      left.show;
      emit(EditUserStatus.error);
    }, (right) {
      AuthBloc.user.email = event.email;
      emit(EditUserStatus.edited);
    });
  }

  Future<void> _editPhonesHandler(EditPhonesEvent event, emit) async {
    emit(EditUserStatus.editing);
    if (!validateMobile(event.phone1)) {
      showToast("هذا الارقام غير صحيحه");
      emit(EditUserStatus.error);
      return;
    }
    Either<Failure, void> value = await _repo.editUser(AuthBloc.user
        .copyWith(phoneNumber: event.phone1, secondPhoneNumber: event.phone2));

    value.fold((left) {
      left.show;
      emit(EditUserStatus.error);
    }, (right) {
      AuthBloc.user.phoneNumber = event.phone1;
      AuthBloc.user.secondPhoneNumber = event.phone2;
      emit(EditUserStatus.edited);
    });
  }

  Future<void> _editPasswordHandler(EditPasswordEvent event, emit) async {
    if (event.pass == null) return;
    emit(EditUserStatus.editing);

    Either<Failure, void> value =
        await _repo.editUser(AuthBloc.user.copyWith(password: event.pass));

    value.fold((left) {
      left.show;
      emit(EditUserStatus.error);
    }, (right) {
      AuthBloc.user.password = event.pass;
      emit(EditUserStatus.edited);
    });
  }

  Future<void> _editAddressHandler(EditUserAddress event, emit) async {
    emit(EditUserStatus.editing);
    print(event.addresses);
    Either<Failure, void> value =
        await _repo.editUser(AuthBloc.user.copyWith(places: event.addresses));

    value.fold((left) {
      left.show;
      emit(EditUserStatus.error);
    }, (right) {
      AuthBloc.user.places = event.addresses;
      emit(EditUserStatus.edited);
    });
  }
}
