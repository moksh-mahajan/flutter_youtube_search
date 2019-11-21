import 'package:bloc/bloc.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';
import 'package:youtube_search/ui/search/search_event.dart';
import 'package:youtube_search/ui/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository _youtubeRepository;

  SearchBloc(this._youtubeRepository) : super();
  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(
    SearchState currentState,
    SearchEvent event,
  ) async* {
    if (event is SearchInitiatedEvent) {
      yield* mapSearchInitiated(event);
    } else if (event is FetchNextPageResultsEvent) {
       yield* mapFetchNextResultPage();
    }
  }

  Stream<SearchState> mapSearchInitiated(SearchInitiatedEvent event) async* {
    if (event.query.isEmpty) {
        yield SearchState.initial();
      } else {
        yield SearchState.loading();

        try {
          final searchResult =
              await _youtubeRepository.searchVideos(event.query);
          yield SearchState.success(searchResult);
        } on YoutubeSearchError catch (e) {
          yield SearchState.failure(e.message);
        } on NoSearchResultsException catch (e) {
          yield SearchState.failure(e.message);
        }
      }
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final nextPageResults = await _youtubeRepository.fetchNextResultPage();
      yield SearchState.success(currentState.searchResults + nextPageResults);
    } on NoNextPageTokenException catch (_) {
      yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
    } on SearchNotInitiatedException catch (e) {
      yield SearchState.failure(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchState.failure(e.message);
    }
  }

  void onSearchInitiated(String query) {
    dispatch(SearchInitiatedEvent((b) => b..query = query));
  }

  void onFetchNextPageResults() {
    dispatch(FetchNextPageResultsEvent());
  }
}
