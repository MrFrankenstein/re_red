import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:intl/intl.dart';

import 'package:re_red/constants.dart';
import 'package:re_red/styles_getter.dart';

class PostCard extends StatelessWidget {
  PostCard({this.post});

  final Submission post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Container(
                  height: 30,
                  width: 30,
                  color:
                      subredditStyles[post.subreddit.displayName].primaryColor,
                  child: subredditStyles[post.subreddit.displayName]
                              .subredditIconUrl ==
                          ""
                      ? Icon(
                          Icons.ac_unit_outlined,
                          size: 22,
                          color: subredditStyles[post.subreddit.displayName]
                                      .primaryColor
                                      .computeLuminance() >
                                  0.5
                              ? Color(0xff252527)
                              : Color(0xfff8f8f8),
                        )
                      : Image.network(
                          subredditStyles[post.subreddit.displayName]
                              .subredditIconUrl),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.subreddit.displayName,
                    style: kPostSubreddit,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: post.author, style: kPostAuthor),
                        kDotSeparator,
                        TextSpan(
                          text: DateTime.now()
                              .toUtc()
                              .difference(post.createdUtc)
                              .inHours
                              .toString(),
                          style: kPostAuthor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            post.title,
            style: kPostTitle,
            // textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.import_export,
                    color: Colors.white70,
                    size: 18,
                  ),
                  Text(
                    NumberFormat.compact().format(post.score),
                    style: kPostScore,
                  ),
                ],
              ),
              SizedBox(width: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(
                  Icons.mode_comment_outlined,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
              Text(
                NumberFormat.compact().format(post.numComments),
                style: kPostScore,
              ),
              Spacer(),
              Container(
                height: 2,
                width: post.upvoteRatio * 100,
                color: Colors.redAccent,
              ),
              Container(
                height: 2,
                width: 100 - (post.upvoteRatio * 100),
                color: Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
