import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:youtube_search/data/model/search/model_search.dart';
import 'package:youtube_search/ui/search/search_state.dart';
import 'package:youtube_search/ui/search/widgets/centered_message.dart';
import 'package:youtube_search/ui/search/widgets/search_bar.dart';
import 'package:youtube_search/ui/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = kiwi.Container().resolve<SearchBloc>();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _searchBloc,
      child: _buildScaffold(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchBloc.dispose();
  }

  Scaffold _buildScaffold() => Scaffold(
        appBar: AppBar(
          title: SearchBar(),
        ),
        body: BlocBuilder(
          bloc: _searchBloc,
          builder: (context, SearchState state) {
            if (state.isInitial) {
              return CenteredMessage(
                  icon: Icons.ondemand_video, message: 'Start searching');
            }
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.isSuccessful) {
              return _buildResultList(state);
            }
            return CenteredMessage(
              icon: Icons.error_outline,
              message: state.error,
            );
          },
        ),
      );

  Widget _buildResultList(SearchState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _calculateResultItemCount(state),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return index >= state.searchResults.length
              ? _buildLoaderListItem()
              : _buildVideoListItemCard(state.searchResults[index].snippet);
        },
      ),
    );
  }

  int _calculateResultItemCount(SearchState state) {
    if (state.hasReachedEndOfResults) {
      return state.searchResults.length;
    } else {
      return state.searchResults.length + 1;
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.onFetchNextPageResults();
    }
    return false;
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildVideoListItemCard(SearchSnippet snippet) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  snippet.thumbnails.high.url,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              snippet.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 20,),
            ),
            SizedBox(height: 5,),
            Text(snippet.description),
          ],
        ),
      ),
    );
  }
}
