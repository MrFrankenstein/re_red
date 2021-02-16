import 'package:flutter/material.dart';

const String kUserAgent = 'foobarding';
const String kClientId = '1MXSUGfpEDj5hA';
const String kDeviceId =
    'okeithsldkthisngiaktneikj'; //TODO - Implement a unique device ID generation and caching mechanism

const Color kPrimaryShade = Color(0xFF223459);
const Color kRedShade = Color(0xE68C0335);
const Color kBlueShade = Color(0xE65888A6);

final RichText kAppBarTitle = RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 're:',
        style: TextStyle(
          color: Colors.red[50],
          fontFamily: 'CormorantGaramond',
          fontSize: 23,
          letterSpacing: 1,
        ),
      ),
      TextSpan(
        text: 'Red',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'CormorantGaramond',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.3,
        ),
      ),
    ],
  ),
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
