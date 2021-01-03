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
          return ListView.separated(
            itemBuilder: (context, index) {
              return contentGetter.contentWidget(index);
            },
            itemCount: contentGetter.contentCount + 1,
            separatorBuilder: (context, i) => Divider(
              color: Colors.white,
              height: 0,
              indent: 35,
              endIndent: 35,
            ),
          );
        },
      ),
    );
  }
}
