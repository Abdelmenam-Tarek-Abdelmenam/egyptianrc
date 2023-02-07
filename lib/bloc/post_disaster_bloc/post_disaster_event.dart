part of 'post_disaster_bloc.dart';


class PostDisasterEvent {
  DisasterPost disasterPost;
  PostDisasterEvent({required this.disasterPost});

  List<Object> get props => [
        disasterPost,
      ];
}