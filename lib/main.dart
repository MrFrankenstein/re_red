import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:re_red/landing_page.dart';
import 'package:re_red/login_flow.dart';
import 'package:re_red/home_page.dart';

void main() => runApp(ReRed());

class ReRed extends StatelessWidget {
  const ReRed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 're:Red',
      theme: ThemeData.dark(),
      initialRoute: 'landing',
      routes: <String, WidgetBuilder>{
        'landing': (context) => LandingPage(),
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
    );
  }
}
