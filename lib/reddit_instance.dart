import 'package:flutter/foundation.dart';
import 'package:draw/draw.dart';
import 'package:re_red/constants.dart';

class RedditInstance with ChangeNotifier {
  Reddit untrustedInstance;

  Future<Reddit> createUntrustedRedditInstance() async {
    untrustedInstance = await Reddit.createUntrustedReadOnlyInstance(
      userAgent: kUserAgent,
      clientId: kClientId,
      deviceId: kDeviceId,
    );
    return untrustedInstance;
  }
}
