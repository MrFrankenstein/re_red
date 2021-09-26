import 'package:flutter/material.dart';

import 'package:re_red/browse_flow.dart';
import 'package:re_red/commons.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              landingDingo,
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              titleLogo,
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: loginButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pushNamed('login');
                        },
                        child: Text(
                          'login',
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: browseButtonStyle,
                        onPressed: () async {
                          await BrowseFlow(context: context).startBrowseFlow();
                        },
                        child: Text(
                          'browse',
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
