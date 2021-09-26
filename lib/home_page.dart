import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import 'package:re_red/commons.dart';
import 'package:re_red/content_getter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Reddit reddit = ModalRoute.of(context)!.settings.arguments as Reddit;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: smallTitleLogo,
            centerTitle: true,
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: primaryShade,
          ),
          ContentView(reddit: reddit),
        ],
      ),
    );
  }
}
