import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:re_red/post_cards.dart';
import 'package:re_red/styles_getter.dart';

class ContentView extends StatelessWidget {
  ContentView({required this.reddit});
  final Reddit reddit;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentGetter>(
      create: (context) => ContentGetter(reddit),
      child: Consumer<ContentGetter>(
        builder: (context, contentGetter, child) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return contentGetter.connectionState == ConnectionState.done
                    ? contentGetter.contentWidget(index)
                    : Center(child: LinearProgressIndicator());
              },
              childCount: contentGetter.contentCount + 1,
            ),
          );
        },
      ),
    );
  }
}

class ContentGetter with ChangeNotifier {
  ContentGetter(this.reddit);
  final Reddit reddit;

  String? lastID;
  var contentList = <Submission>[];
  StylesGetter stylesGetter = StylesGetter();

  ConnectionState connectionState = ConnectionState.done;
  int get contentCount => contentList.length;

  void getMoreContent() async {
    connectionState = ConnectionState.active;
    var generatedContent = await reddit.front
        .hot(limit: 20, after: lastID)
        .map((event) => event as Submission)
        .toList();
    contentList.addAll(generatedContent);
    connectionState = ConnectionState.done;
    lastID = contentList.last.fullname;
    await stylesGetter.getStyles(generatedContent);
    notifyListeners();
  }

  Widget contentWidget(int index) {
    if (connectionState == ConnectionState.done && index < contentCount) {
      return PostCard(post: contentList[index]);
    } else {
      getMoreContent();
      return Center(child: LinearProgressIndicator());
    }
  }
}
