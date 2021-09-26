import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:re_red/commons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController _webViewController;
  ProgressState _progressState = ProgressState.empty;
  double _pageLoadingProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    final _redditGetter = RedditGetter.loginFlow();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'reddit login',
          style: buttonTextStyle,
        ),
        backgroundColor: Colors.red,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _webViewController.clearCache();
              CookieManager().clearCookies();
              _webViewController.reload();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _pageLoadingProgress,
            backgroundColor: Colors.cyan,
            color: Colors.red,
          ),
          Expanded(
            child: WebView(
              initialUrl: _redditGetter.reddit.auth.url(
                ['*'],
                authState,
                compactLogin: true,
              ).toString(),
              onWebViewCreated: (_controller) {
                _webViewController = _controller;
              },
              onProgress: (progress) {
                setState(() {
                  _pageLoadingProgress = progress / 100;
                });
              },
              onPageStarted: (_url) async {
                if (_url.startsWith(redirectUri.toString()) &&
                    !(_progressState == ProgressState.inProgress)) {
                  _webViewController.loadUrl('about://blank');
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: CircleBorder(),
                      contentPadding: EdgeInsets.all(8),
                      content: Container(
                        width: 50,
                        height: 50,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  );
                  final Uri _oauthData = Uri.parse(_url);
                  try {
                    _progressState = ProgressState.inProgress;
                    await _redditGetter.reddit.auth
                        .authorize(_oauthData.queryParameters['code']!);
                    _progressState = ProgressState.finished;
                    loginStatus = LoginState.successful;
                    Navigator.pop(context);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('home',
                        arguments: _redditGetter.reddit);
                  } catch (_) {
                    print('--------------exception $_');
                    loginStatus = LoginState.failed;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[900],
                        content: Row(
                          children: [
                            Icon(Icons.error_outline),
                            Text(
                              '  reddit login failed, try again',
                              style: buttonTextStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RedditGetter {
  RedditGetter({redditInstance, authState}) : this.reddit = redditInstance;
  final Reddit reddit;

  factory RedditGetter.loginFlow() {
    final reddit = Reddit.createInstalledFlowInstance(
      clientId: clientId,
      userAgent: userAgent,
      redirectUri: redirectUri,
    );
    return RedditGetter(redditInstance: reddit);
  }
}
