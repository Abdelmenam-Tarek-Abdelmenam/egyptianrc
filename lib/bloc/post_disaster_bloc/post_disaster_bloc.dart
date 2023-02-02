import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_disaster_event.dart';
part 'post_disaster_state.dart';

class PostDisasterBloc extends Bloc<PostDisasterEvent, PostDisasterState> {
  PostDisasterBloc() : super(PostDisasterInitial()) {
    on<PostDisasterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
