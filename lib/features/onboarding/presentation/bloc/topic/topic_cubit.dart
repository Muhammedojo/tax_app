import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api/repository/repository_contract.dart';
import '../../../../../core/data/model/topic.dart';

part 'topic_state.dart';

class TopicCubit extends Cubit<TopicState> {
  final IAppRepository repository;
  TopicCubit({required this.repository}) : super(TopicLoading());

  Future<void> loadTopicsFromServer() async {
    try {
      emit(TopicLoading());
      final response = await repository.getTopicList();
      response.fold(
        (l) {
          debugPrint("Topic Loading Failure: ${l.failureMessage()}");
          emit(TopicFailure(l.failureMessage()));
        },
        (r) async {
          debugPrint("Topic Loading Success: ${r.message}");
          emit(TopicLoaded(r.data!));
        },
      );
    } catch (e) {
      debugPrint("problem sending request: ${e.toString()}");
      emit(TopicFailure('An error occurred. Please try again.'));
    }
  }
}
