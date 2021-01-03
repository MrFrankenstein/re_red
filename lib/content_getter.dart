import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import 'package:re_red/post_cards.dart';
import 'package:re_red/styles_getter.dart';

class ContentGetter with ChangeNotifier {
  ContentGetter(this.reddit);
  final Reddit reddit;

  String lastID;
  var contentList = <Submission>[];
  StylesGetter stylesGetter = StylesGetter();

  ConnectionState connectionState = ConnectionState.none;
  int get contentCount {
    return contentList.length;
  }

  void getMoreContent() async {
    connectionState = ConnectionState.active;
    var generatedContent = await reddit.front
        .hot(limit: 20, after: lastID)
        .map((event) => toSubmission(event))
        .toList();
    contentList.addAll(generatedContent);
    connectionState = ConnectionState.done;
    lastID = contentList.last.fullname;
    await stylesGetter.getStyles(generatedContent);
    notifyListeners();
  }

  Submission toSubmission(UserContent userContent) {
    Submission submission = userContent;
    return submission;
  }

  Widget contentWidget(int index) {
    if (connectionState == ConnectionState.done && index < contentCount) {
      //return Text(contentList[index].title);
      return PostCard(post: contentList[index]);
    } else {
      getMoreContent();
      return Center(child: LinearProgressIndicator());
    }
  }
}
