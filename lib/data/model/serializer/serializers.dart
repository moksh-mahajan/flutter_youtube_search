library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:youtube_search/data/model/common/thumbnail.dart';
import 'package:youtube_search/data/model/common/thumbnails.dart';
import 'package:youtube_search/data/model/detail/video_item.dart';
import 'package:youtube_search/data/model/detail/video_snippet.dart';
import 'package:youtube_search/data/model/detail/youtube_video_response.dart';
import 'package:youtube_search/data/model/search/model_search.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  YoutubeSearchResult,
  SearchItem,
  Id,
  SearchSnippet,
  Thumbnails,
  Thumbnail,
  VideoSnippet,
  VideoItem,
  YoutubeVideoResponse,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
