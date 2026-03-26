part of 'topic_cubit.dart';

sealed class TopicState extends Equatable {
  const TopicState();

  @override
  List<Object> get props => [];
}

class TopicLoading extends TopicState {}

class TopicLoaded extends TopicState {
  final List<Topic> topicList;

  const TopicLoaded(this.topicList);

  @override
  List<Object> get props => [topicList];

  @override
  String toString() => 'TopicLoaded { Topic: $topicList }';
}

class TopicNotLoaded extends TopicState {}

class TopicFailure extends TopicState {
  final String error;

  const TopicFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'TopicFailure { error: $error }';
}
