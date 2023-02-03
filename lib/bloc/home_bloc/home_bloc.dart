import 'package:bloc/bloc.dart';
import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../presentation/view/landing_view/home_view/home_view.dart';
import '../../presentation/view/landing_view/user_view/user_view.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeStatus> {
  HomeBloc() : super(HomeStatus.home) {
    on<ChangeHomePage>(_changeHandler);
  }

  void _changeHandler(ChangeHomePage event, Emitter emit) => emit(event.status);
}
