// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchInitiatedEvent extends SearchInitiatedEvent {
  @override
  final String query;

  factory _$SearchInitiatedEvent(
          [void Function(SearchInitiatedEventBuilder) updates]) =>
      (new SearchInitiatedEventBuilder()..update(updates)).build();

  _$SearchInitiatedEvent._({this.query}) : super._() {
    if (query == null) {
      throw new BuiltValueNullFieldError('SearchInitiatedEvent', 'query');
    }
  }

  @override
  SearchInitiatedEvent rebuild(
          void Function(SearchInitiatedEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchInitiatedEventBuilder toBuilder() =>
      new SearchInitiatedEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchInitiatedEvent && query == other.query;
  }

  @override
  int get hashCode {
    return $jf($jc(0, query.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchInitiatedEvent')
          ..add('query', query))
        .toString();
  }
}

class SearchInitiatedEventBuilder
    implements Builder<SearchInitiatedEvent, SearchInitiatedEventBuilder> {
  _$SearchInitiatedEvent _$v;

  String _query;
  String get query => _$this._query;
  set query(String query) => _$this._query = query;

  SearchInitiatedEventBuilder();

  SearchInitiatedEventBuilder get _$this {
    if (_$v != null) {
      _query = _$v.query;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchInitiatedEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SearchInitiatedEvent;
  }

  @override
  void update(void Function(SearchInitiatedEventBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchInitiatedEvent build() {
    final _$result = _$v ?? new _$SearchInitiatedEvent._(query: query);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
