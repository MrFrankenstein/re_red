import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:re_red/content_getter.dart';

class ContentView extends StatelessWidget {
  ContentView({@required this.reddit});

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
