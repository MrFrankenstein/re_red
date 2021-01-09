import 'package:flutter/material.dart';

const String kUserAgent = 'foobarding';
const String kClientId = '1MXSUGfpEDj5hA';
const String kDeviceId =
    'okeithsldkthisngiaktneikj'; //TODO - Implement a unique device ID generation and caching mechanism

const TextStyle kAppBarTitle = TextStyle(
  fontFamily: 'Lora',
  fontSize: 22,
  letterSpacing: 1.5,
);
const TextStyle kPostTitle = TextStyle(
  color: Colors.white,
  fontFamily: 'NewYork',
  letterSpacing: 0.5,
  fontSize: 17,
);
const TextStyle kPostSubreddit = TextStyle(
  color: Colors.white,
  fontFamily: 'Raleway',
  letterSpacing: 0.8,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);
const TextStyle kPostAuthor = TextStyle(
  color: Colors.white70,
  fontFamily: 'OpenSans',
  letterSpacing: 0.3,
  fontSize: 11,
);
const TextStyle kPostScore = TextStyle(
  color: Colors.white70,
  fontFamily: 'OpenSans',
  letterSpacing: 0.3,
  fontSize: 13,
);
const TextSpan kDotSeparator = TextSpan(
  text: ' • ',
  style: TextStyle(
    color: Colors.white70,
    fontSize: 12,
  ),
);
