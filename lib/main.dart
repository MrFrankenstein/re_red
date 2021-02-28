import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:re_red/reddit_instance.dart';
import 'package:re_red/content_view.dart';
import 'package:re_red/constants.dart';

void main() => runApp(ReReddit());

class ReReddit extends StatefulWidget {
  @override
  _ReRedditState createState() => _ReRedditState();
}

class _ReRedditState extends State<ReReddit> {
  final RedditInstance getRedditInstance = RedditInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: CustomScrollView(
          cacheExtent: 100,
          slivers: [
            SliverAppBar(
              title: kAppBarTitle,
              centerTitle: true,
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: kPrimaryShade,
            ),
            FutureProvider<Reddit>(
              create: (context) =>
                  getRedditInstance.createUntrustedRedditInstance(),
              child: Consumer<Reddit>(
                builder: (context, reddit, child) {
                  return getRedditInstance.untrustedInstance == null
                      ? SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ContentView(
                          reddit: getRedditInstance.untrustedInstance);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
