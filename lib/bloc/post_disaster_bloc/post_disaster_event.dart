part of 'post_disaster_bloc.dart';

abstract class PostDisasterEvent extends Equatable {
  const PostDisasterEvent();

  @override
  List<Object> get props => [];
}

class PostLocationEvent extends PostDisasterEvent {
  const PostLocationEvent({required this.location});
  
  final Location location;

  @override
  List<Object> get props => [
        location,
      ];
}
