library search_event;

import 'package:built_value/built_value.dart';

part 'search_event.g.dart';

abstract class SearchEvent {}

abstract class SearchInitiatedEvent extends SearchEvent
    implements Built<SearchInitiatedEvent, SearchInitiatedEventBuilder> {
  String get query;

  SearchInitiatedEvent._();

  factory SearchInitiatedEvent([updates(SearchInitiatedEventBuilder b)]) =
      _$SearchInitiatedEvent;
}

class FetchNextPageResultsEvent extends SearchEvent {}
