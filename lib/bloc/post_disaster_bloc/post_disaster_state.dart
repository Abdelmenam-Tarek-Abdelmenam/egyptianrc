part of 'post_disaster_bloc.dart';

abstract class PostDisasterState extends Equatable {
  const PostDisasterState();
  
  @override
  List<Object> get props => [];
}

class PostDisasterInitial extends PostDisasterState {}
