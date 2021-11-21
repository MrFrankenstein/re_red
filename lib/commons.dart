import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Landing page backdrop
const String landingDingo = 'assets/dingo.png';

// Login states
enum LoginState { successful, failed, none }
LoginState loginStatus = LoginState.none;

// Progress states
enum ProgressState { started, inProgress, finished, empty }

// Reddit client config
const String clientId = '1MXSUGfpEDj5hA';
const String userAgent = 'rered-sonderer';
const String authState = 'rered-sonder';
final String deviceId = Uuid().v4();
final Uri redirectUri = Uri.parse('https://www.google.com');

// Text style on buttons
const TextStyle buttonTextStyle = TextStyle(
  fontFamily: 'Raleway',
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Title to be used as Logo
final RichText titleLogo = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: 're:',
        style: TextStyle(
          fontFamily: 'SanFrancisco Mono',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 3)],
        ),
      ),
      TextSpan(
        text: 'Red',
        style: TextStyle(
          fontFamily: 'OldLondon',
          fontSize: 60,
          letterSpacing: 1,
          shadows: [Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 3)],
        ),
      ),
    ],
  ),
);

// Title to be used as small Logo
final RichText smallTitleLogo = RichText(
  text: TextSpan(
    children: <TextSpan>[
      TextSpan(
        text: 're:',
        style: TextStyle(
          fontFamily: 'SanFrancisco Mono',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 3)],
        ),
      ),
      TextSpan(
        text: 'Red',
        style: TextStyle(
          fontFamily: 'OldLondon',
          fontSize: 34,
          letterSpacing: 1,
          shadows: [Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 3)],
        ),
      ),
    ],
  ),
);

// Login and Browse buttons
final ButtonStyle loginButtonStyle = ElevatedButton.styleFrom(
  primary: neonRed,
  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  shape: RoundedRectangleBorder(),
);
final ButtonStyle browseButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.blue,
  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  shape: RoundedRectangleBorder(),
);

// Colors
const Color primaryShade = Color(0xFF223459);
const Color redShade = Color(0xE68C0335);
const Color blueShade = Color(0xE65888A6);
const Color greyShade = Color(0xFFE8E8E8);
const Color neonRed = Color(0xFFFF1818);
const Color neonBlue = Color(0xFF04D9FF);

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
  shadows: [
    Shadow(
      color: Colors.black,
      offset: Offset(1, 1),
      blurRadius: 5,
    ),
  ],
);
const TextStyle kPostSubreddit = TextStyle(
  color: Colors.white,
  fontFamily: 'Raleway',
  letterSpacing: 0.8,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  shadows: [
    Shadow(
      color: Colors.black,
      offset: Offset(1, 1),
      blurRadius: 5,
    ),
  ],
);
const TextStyle kPostAuthor = TextStyle(
  color: greyShade,
  fontFamily: 'OpenSans',
  letterSpacing: 0.3,
  fontSize: 11,
  shadows: [
    Shadow(
      color: Colors.black,
      offset: Offset(1, 1),
      blurRadius: 5,
    ),
  ],
);
const TextStyle kPostScore = TextStyle(
  color: greyShade,
  fontFamily: 'OpenSans',
  letterSpacing: 0.3,
  fontSize: 13,
  shadows: [
    Shadow(
      color: Colors.black,
      offset: Offset(1, 1),
      blurRadius: 5,
    ),
  ],
);
const TextSpan kDotSeparator = TextSpan(
  text: ' • ',
  style: TextStyle(
    color: Colors.white70,
    fontSize: 12,
  ),
);

const BorderSide kBorderStyle = BorderSide(
  color: Colors.black38,
  width: 1,
);
