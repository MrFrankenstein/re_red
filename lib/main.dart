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
    //print('started widget build');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        // backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text('re: Red', style: kAppBarTitle),
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: FutureProvider<Reddit>(
          create: (context) =>
              getRedditInstance.createUntrustedRedditInstance(),
          child: Consumer<Reddit>(
            builder: (context, reddit, child) {
              return Center(
                child: getRedditInstance.untrustedInstance == null
                    ? CircularProgressIndicator()
                    : ContentView(reddit: getRedditInstance.untrustedInstance),
              );
            },
          ),
        ),
      ),
    );
  }
}
