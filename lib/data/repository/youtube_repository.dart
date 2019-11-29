import 'package:built_collection/built_collection.dart';
import 'package:youtube_search/data/model/detail/video_item.dart';
import 'package:youtube_search/data/model/detail/youtube_video_response.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/data/network/youtube_data_source.dart';

class YoutubeRepository {
  YoutubeDataSource _youtubeDataSource;
  String _lastSearchQuery;
  String _nextPageToken;

  YoutubeRepository(this._youtubeDataSource);

  Future<BuiltList<SearchItem>> searchVideos(String query) async {
    final YoutubeSearchResult searchResult =
        await _youtubeDataSource.searchVideos(query: query);
    _cacheValues(query, searchResult.nextPageToken);
    if (searchResult.items.isEmpty) throw NoSearchResultsException();
    return searchResult.items;
  }

  Future<VideoItem> fetchVideoInfo({String id}) async {
    final YoutubeVideoResponse videoResponse =
        await _youtubeDataSource.fetchVideoinfo(id: id);
    if (videoResponse.items.isEmpty) {
      throw NoSuchVideoException();
    }
    return videoResponse.items[0];
  }

  void _cacheValues(String query, String pageToken) {
    _lastSearchQuery = query;
    _nextPageToken = pageToken;
  }

  Future<BuiltList<SearchItem>> fetchNextResultPage() async {
    if (_lastSearchQuery == null) throw SearchNotInitiatedException();
    if (_nextPageToken == null) throw NoNextPageTokenException();
    final nextPageSearchResult = await _youtubeDataSource.searchVideos(
        query: _lastSearchQuery, pageToken: _nextPageToken);
    _cacheValues(_lastSearchQuery, nextPageSearchResult.nextPageToken);
    return nextPageSearchResult.items;
  }
}

class NoSearchResultsException implements Exception {
  final message = 'No Results';
}

class SearchNotInitiatedException implements Exception {
  final message = 'Cannot get the next page without searching first...';
}

class NoNextPageTokenException implements Exception {}

class NoSuchVideoException implements Exception {
  final message = 'No such video';
}
