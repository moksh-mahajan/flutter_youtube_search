import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search/data/model/detail/youtube_video_error.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  YoutubeRepository _repository;
  @override
  DetailState get initialState => DetailState.initital();

  DetailBloc(this._repository);

  void onShowDetail({@required String id}) {
    dispatch(ShowDetail((b) => b..id = id));
  }

  @override
  Stream<DetailState> mapEventToState(
      DetailState currentState, DetailEvent event) async* {
    if (event is ShowDetail) {
      yield DetailState.isLoading();
      try {
        final videoItem = await _repository.fetchVideoInfo(id: event.id);
        yield DetailState.success(videoItem);
      } on YoutubeVideoError catch (e) {
        yield DetailState.failure(e.message);
      } on NoSuchVideoException catch (e) {
        yield DetailState.failure(e.message);
      }
    }
  }
}
