part of 'post_disaster_bloc.dart';

abstract class PostDisasterEvent {
  PostDisasterEvent();

  List<Object> get props => [];
}

class PostDisasterToCloudEvent extends PostDisasterEvent {
  DisasterPost disasterPost;
  PostDisasterToCloudEvent({required this.disasterPost});
  @override
  List<Object> get props => [disasterPost];
}

class PostPhotoDisasterEvent extends PostDisasterEvent {
  final UploadFile mediaFile;
  final bool isEnd;
  PostPhotoDisasterEvent({required this.mediaFile, required this.isEnd});

  @override
  List<Object> get props => [mediaFile];
}

class PostAudioDisasterEvent extends PostDisasterEvent {
  UploadFile mediaFile;
  PostAudioDisasterEvent({required this.mediaFile});

  @override
  List<Object> get props => [mediaFile];
}
