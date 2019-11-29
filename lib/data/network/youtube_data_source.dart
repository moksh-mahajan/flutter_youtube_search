import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_search/data/model/detail/youtube_video_error.dart';
import 'package:youtube_search/data/model/detail/youtube_video_response.dart';
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/data/network/api_key.dart';

const String SEARCH_MAX_RESULTS = '10';

class YoutubeDataSource {
  final http.Client client;
  final _searchBaseURL =
      'https://www.googleapis.com/youtube/v3/search?part=snippet' +
          '&maxResults=$SEARCH_MAX_RESULTS&type=video&key=$API_KEY';
  final _videoBaseURL = 'https://wwww.googleapis.com/youtube/v3/videos?part=snippet&key=$API_KEY';

  YoutubeDataSource(this.client);

  Future<YoutubeSearchResult> searchVideos(
      {String query, String pageToken = ''}) async {
    final rawURL = _searchBaseURL +
        '&q=$query' +
        (pageToken.isNotEmpty ? '&pageToken=$pageToken' : '');
    final urlEncoded = Uri.encodeFull(rawURL);

    final response = await client.get(urlEncoded);
    if (response.statusCode == 200) {
      return YoutubeSearchResult.fromJson(response.body);
    } else {
      throw YoutubeSearchError(json.decode(response.body)['error']['message']);
    }
  }

  Future<YoutubeVideoResponse> fetchVideoinfo({String id}) async {
    final rawURL = _videoBaseURL + '&id=$id';
    final response = await client.get(rawURL);
    if (response.statusCode == 200) {
      return YoutubeVideoResponse.fromJson(response.body);
    } else {
      throw YoutubeVideoError(json.decode(response.body)['error']['message']);
    }
  }
}
