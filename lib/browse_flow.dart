import 'package:draw/draw.dart';
import 'package:flutter/material.dart';

import 'package:re_red/commons.dart';

class BrowseFlow {
  BrowseFlow({context}) : this._context = context;
  final BuildContext _context;

  Future<void> startBrowseFlow() async {
    showDialog(
      context: _context,
      builder: (_) => AlertDialog(
        shape: CircleBorder(),
        contentPadding: EdgeInsets.all(8),
        content: Container(
          width: 50,
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
    final Reddit reddit = await Reddit.createUntrustedReadOnlyInstance(
      clientId: clientId,
      userAgent: userAgent,
      deviceId: deviceId,
    );
    Navigator.of(_context).pop();
    Navigator.of(_context).pushReplacementNamed('home', arguments: reddit);
  }
}
