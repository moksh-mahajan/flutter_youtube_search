import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;
import 'package:youtube_search/ui/search/search_bloc.dart';

import 'data/network/youtube_data_source.dart';
import 'data/repository/youtube_repository.dart';
void initKiwi() {
  kiwi.Container()..registerInstance(http.Client())
  ..registerFactory((c) => YoutubeDataSource(c.resolve()))
  ..registerFactory((c) => YoutubeRepository(c.resolve()))
  ..registerFactory((c) => SearchBloc(c.resolve()))
  ;
}