part of 'edit_user_bloc.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();
}

class EditNameEvent extends EditUserEvent {
  final String name;

  const EditNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class EditPhonesEvent extends EditUserEvent {
  final String phone1;
  final String phone2;

  const EditPhonesEvent(this.phone1, this.phone2);

  @override
  List<Object?> get props => [phone1, phone2];
}

class EditEmailEvent extends EditUserEvent {
  final String email;

  const EditEmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class EditPasswordEvent extends EditUserEvent {
  final String? pass;

  const EditPasswordEvent(this.pass);

  @override
  List<Object?> get props => [pass];
}

class EditUserAddress extends EditUserEvent {
  final List<String>? addresses;

  const EditUserAddress(this.addresses);

  @override
  List<Object?> get props => [];
}
